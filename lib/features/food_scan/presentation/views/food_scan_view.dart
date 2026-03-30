import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysterybag/generated/l10n.dart';

import '../../../ai_chat/presentation/views/ai_chat_view.dart';
import '../../data/ml/tflite_food_classifier.dart';

class FoodScanView extends StatefulWidget {
  const FoodScanView({super.key});

  static const String routeName = '/foodScan';

  @override
  State<FoodScanView> createState() => _FoodScanViewState();
}

class _FoodScanViewState extends State<FoodScanView> {
  final _picker = ImagePicker();
  final _classifier = TfliteFoodClassifier();

  XFile? _image;
  bool _loadingModel = true;
  String? _modelError;

  bool _busy = false;

  String? _detectedFood;
  double? _confidence;

  String? _spoilageResult;
  bool _spoilageBusy = false;

  static const double _minConfidenceToShowLabel = 0.35;
  static const String _proxyBaseUrl =
      'https://mystreybox-gemini-proxy.sinshi.workers.dev';

  String? _sanitizeLabel(String? raw) {
    if (raw == null) return null;
    final label = raw.trim();
    if (label.isEmpty) return null;

    final lower = label.toLowerCase();
    if (lower == '__background__') return null;
    if (lower.startsWith('/g/') || lower.startsWith('/m/')) return null;
    if (lower.startsWith('http://') || lower.startsWith('https://'))
      return null;

    final cleaned = label.replaceAll('"', '').trim();
    if (cleaned.isEmpty) return null;
    return cleaned;
  }

  Future<void> _checkSpoilage() async {
    if (_spoilageBusy) return;
    final img = _image;
    if (img == null) return;

    setState(() {
      _spoilageBusy = true;
      _spoilageResult = null;
    });

    try {
      final bytes = await File(img.path).readAsBytes();
      final b64 = base64Encode(bytes);
      final label = _detectedFood;
      final prompt =
          'حلّل الصورة وحدد هل الأكل يبدو متعفّن/فاسد أم لا بناءً على المظهر فقط.\n'
          'لو مش متأكد، قل "غير مؤكد".\n\n'
          'اكتب الرد بالعربي وبشكل منظم في 3 نقاط:\n'
          '1) الحكم: (غالبًا سليم / غير مؤكد / غالبًا فاسد).\n'
          '2) علامات مرصودة في الصورة: 3-5 نقاط (لون غير طبيعي/بقع/عفن/سوائل/انهيار قوام...).\n'
          '3) نصيحة أمان: ماذا أفعل الآن؟ (متى أرميه/متى أغسله/متى أتجنب الأكل).\n\n'
          '${label == null ? '' : 'معلومة إضافية: نوع الأكل المتوقع: "$label".\n'}'
          'مهم: لا تعتبره تشخيص طبي، واعتمد على السلامة أولًا.';

      final uri = Uri.parse('$_proxyBaseUrl/vision');
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 20);

      try {
        final req = await client.postUrl(uri);
        req.headers.contentType = ContentType.json;
        req.write(
          jsonEncode({
            'prompt': prompt,
            'imageBase64': b64,
            'mimeType': 'image/jpeg',
          }),
        );

        final resp = await req.close();
        final body = await resp.transform(utf8.decoder).join();
        debugPrint('[PROXY] Status: ${resp.statusCode}');
        debugPrint('[PROXY] Body: $body');
        if (resp.statusCode < 200 || resp.statusCode >= 300) {
          throw HttpException(
            'proxy_error_${resp.statusCode}: $body',
            uri: uri,
          );
        }

        final json = jsonDecode(body);
        final reply = json is Map ? json['reply'] : null;
        final text = reply is String ? reply.trim() : '';
        if (!mounted) return;
        setState(() {
          _spoilageResult = text.isEmpty
              ? 'تعذر الحصول على نتيجة واضحة من خدمة التحليل. جرّب تاني بصورة أوضح.'
              : text;
        });
      } finally {
        client.close(force: true);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _spoilageResult =
            'ميزة فحص التعفن تحتاج Proxy يدعم تحليل الصور. حاليًا الخدمة رجعت رد غير متوقع.\n\nجرّب تاني لاحقًا أو استخدم "Nutrition & Health".';
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _spoilageBusy = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  @override
  void dispose() {
    _classifier.dispose();
    super.dispose();
  }

  Future<void> _loadModel() async {
    setState(() {
      _loadingModel = true;
      _modelError = null;
    });

    await _classifier.load();

    if (!mounted) return;
    setState(() {
      _loadingModel = false;
      _modelError = _classifier.loadError;
    });
  }

  Future<void> _pickAndScan(ImageSource source) async {
    if (_busy) return;

    setState(() {
      _busy = true;
      _detectedFood = null;
      _confidence = null;
      _spoilageResult = null;
    });

    try {
      final imgFile = await _picker.pickImage(source: source, imageQuality: 90);
      if (imgFile == null) return;

      final bytes = await File(imgFile.path).readAsBytes();
      final best = await _classifier.classifyJpeg(bytes);
      final conf = best?.confidence;
      final label = _sanitizeLabel(best?.label);
      final displayLabel = (conf != null && conf >= _minConfidenceToShowLabel)
          ? label
          : null;

      if (!mounted) return;
      setState(() {
        _image = imgFile;
        _detectedFood = displayLabel;
        _confidence = conf;
      });
    } catch (_) {
      if (!mounted) return;
    } finally {
      if (!mounted) return;
      setState(() {
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final locale = S.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(locale.foodScanTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_loadingModel)
                const LinearProgressIndicator()
              else if (_modelError != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      _modelError!,
                      style: TextStyle(color: scheme.error),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: (_loadingModel || _modelError != null || _busy)
                          ? null
                          : () => _pickAndScan(ImageSource.camera),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: Text(locale.foodScanCameraButton),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: (_loadingModel || _modelError != null || _busy)
                          ? null
                          : () => _pickAndScan(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: Text(locale.foodScanGalleryButton),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    if (_image == null)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 220,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: scheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: scheme.outlineVariant,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.document_scanner_outlined,
                                      size: 54,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      locale.foodScanHeroTitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: scheme.onSurface,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      locale.foodScanHeroSubtitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: scheme.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                locale.foodScanTipsTitle,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _TipChip(
                                      icon: Icons.wb_sunny_outlined,
                                      text: locale.foodScanTipGoodLighting,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _TipChip(
                                      icon: Icons.crop_free,
                                      text: locale.foodScanTipMoveCloser,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _TipChip(
                                      icon: Icons.wallpaper_outlined,
                                      text: locale.foodScanTipSimpleBackground,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _TipChip(
                                      icon: Icons.no_flash_outlined,
                                      text: locale.foodScanTipNoBlur,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                locale.foodScanAfterPickHint,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _FeatureChip(
                                    icon: Icons.restaurant_menu,
                                    text: locale.foodScanFeatureNutrition,
                                  ),
                                  _FeatureChip(
                                    icon: Icons.fact_check_outlined,
                                    text: locale.foodScanFeatureFreshness,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          File(_image!.path),
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (_image != null) const SizedBox(height: 12),
                    if (_busy)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (_detectedFood != null)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.foodScanDetectedLabel,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _detectedFood!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              if (_confidence != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    locale.foodScanConfidenceLabel(
                                      '${(_confidence! * 100).toStringAsFixed(1)}%',
                                    ),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  onPressed: () {
                                    final food = _detectedFood;
                                    if (food == null || food.trim().isEmpty)
                                      return;
                                    final prompt =
                                        'حلّل "$food".\n\n'
                                        'اكتب الرد بالعربي وبشكل مُفصّل ومنظّم في 4 أقسام (من غير مقدمات طويلة):\n'
                                        '1) ملخص سريع: هل هو صحي ولا لأ ولماذا (سطرين).\n'
                                        '2) القيم الغذائية التقريبية: لكل 100g أو للحصة الشائعة (حدد أنت): سعرات، بروتين، كارب، دهون، ألياف، سكر، صوديوم (حتى لو تقديري).\n'
                                        '3) ليه صحي/مش صحي: اذكر الأسباب (سكر عالي/دهون مشبعة/صوديوم عالي/سعرات عالية/إلخ).\n'
                                        '4) نصائح وبدائل: ازاي نخليه healthier + بديلين مناسبين.\n\n'
                                        'مهم: ما تكتبش عنوان وبس؛ لازم أرقام تقريبية ونصايح عملية.';
                                    final display = 'جارٍ تحليل "$food"…';
                                    Navigator.of(context).pushNamed(
                                      AiChatView.routeName,
                                      arguments: {
                                        'initialMessage': prompt,
                                        'initialDisplayMessage': display,
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.restaurant_menu),
                                  label: Text(locale.foodScanFeatureNutrition),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  onPressed: _spoilageBusy
                                      ? null
                                      : _checkSpoilage,
                                  icon: const Icon(Icons.fact_check_outlined),
                                  label: Text(
                                    _spoilageBusy
                                        ? locale.foodScanCheckingFreshness
                                        : locale.foodScanFreshnessSpoilageCheck,
                                  ),
                                ),
                              ),
                              if (_spoilageResult != null) ...[
                                const SizedBox(height: 10),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      _spoilageResult!,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    if (_detectedFood == null && _confidence != null)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            locale.foodScanLowConfidenceMessage,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipChip extends StatelessWidget {
  const _TipChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: scheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: scheme.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
