import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import 'tensor_utils.dart';

class FoodClassification {
  const FoodClassification({
    required this.label,
    required this.confidence,
    required this.index,
  });

  final String label;
  final double confidence;
  final int index;
}

class TfliteFoodClassifier {
  Interpreter? _interpreter;
  List<String> _labels = const [];

  int _inputHeight = 224;
  int _inputWidth = 224;
  int _inputChannels = 3;

  int _numClasses = 0;

  String? _loadError;

  bool get isReady => _interpreter != null;
  String? get loadError => _loadError;
  int get numClasses => _numClasses;

  Future<void> load({
    String modelAssetPath = 'assets/tflite/food_model.tflite',
    String labelsAssetPath = 'assets/tflite/labels.txt',
  }) async {
    _loadError = null;
    _numClasses = 0;

    try {
      try {
        _labels = (await rootBundle.loadString(labelsAssetPath))
            .split('\n')
            .map((line) {
              final parts = line
                  .split(',')
                  .map((p) => p.trim())
                  .where((p) => p.isNotEmpty)
                  .toList(growable: false);
              return parts.isEmpty ? '' : parts.join('/');
            })
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(growable: false);
      } catch (_) {
        _labels = const [];
      }

      _interpreter = await Interpreter.fromAsset(modelAssetPath);

      final t = _interpreter!.getInputTensor(0);
      final shape = t.shape;
      if (shape.length >= 4) {
        _inputHeight = shape[1];
        _inputWidth = shape[2];
        _inputChannels = shape[3];
      } else if (shape.length == 3) {
        _inputHeight = shape[0];
        _inputWidth = shape[1];
        _inputChannels = shape[2];
      }

      final outShape = _interpreter!.getOutputTensor(0).shape;
      if (outShape.isNotEmpty) {
        _numClasses = outShape.reduce((a, b) => a * b);
      }

      if (_labels.isEmpty) {
        _loadError =
            'labels.txt is empty. Provide a labels file with $_numClasses line(s) matching the model output indices.';
      } else if (_numClasses > 0 && _labels.length != _numClasses) {
        _loadError =
            'labels.txt lines (${_labels.length}) do not match model classes ($_numClasses). Please use the correct labels for this model.';
      }
    } catch (e) {
      _interpreter = null;
      _loadError = e.toString();
    }
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }

  List<double>? _runOnJpeg(Uint8List jpegBytes) {
    final interpreter = _interpreter;
    if (interpreter == null) return null;

    final decoded = img.decodeImage(jpegBytes);
    if (decoded == null) return null;

    final h = _inputHeight;
    final w = _inputWidth;
    final c = _inputChannels;

    final resized = img.copyResize(decoded, width: w, height: h);

    final inputShape = interpreter.getInputTensor(0).shape;
    final inputType = interpreter.getInputTensor(0).type;

    Object modelInput;
    if (inputType == TensorType.float32) {
      final input = Float32List(1 * h * w * c);
      var i = 0;
      for (var y = 0; y < h; y++) {
        for (var x = 0; x < w; x++) {
          final pixel = resized.getPixel(x, y);
          final r = (pixel.r - 128.0) / 128.0;
          final g = (pixel.g - 128.0) / 128.0;
          final b = (pixel.b - 128.0) / 128.0;

          if (c == 1) {
            input[i++] = (0.299 * r) + (0.587 * g) + (0.114 * b);
          } else {
            input[i++] = r;
            if (c >= 2) input[i++] = g;
            if (c >= 3) input[i++] = b;
            for (var cc = 3; cc < c; cc++) {
              input[i++] = 0;
            }
          }
        }
      }

      modelInput = reshapeFlatList<double>(
        input.toList(growable: false),
        inputShape,
      );
    } else if (inputType == TensorType.uint8) {
      final u8 = Uint8List(1 * h * w * c);
      var i = 0;
      for (var y = 0; y < h; y++) {
        for (var x = 0; x < w; x++) {
          final pixel = resized.getPixel(x, y);
          if (c == 1) {
            final v = (0.299 * pixel.r) + (0.587 * pixel.g) + (0.114 * pixel.b);
            u8[i++] = v.clamp(0, 255).toInt();
          } else {
            u8[i++] = pixel.r.clamp(0, 255).toInt();
            if (c >= 2) u8[i++] = pixel.g.clamp(0, 255).toInt();
            if (c >= 3) u8[i++] = pixel.b.clamp(0, 255).toInt();
            for (var cc = 3; cc < c; cc++) {
              u8[i++] = 0;
            }
          }
        }
      }
      modelInput = reshapeFlatList<int>(u8.toList(growable: false), inputShape);
    } else {
      return null;
    }

    final outputTensor = interpreter.getOutputTensor(0);
    final outputShape = outputTensor.shape;
    final outputType = outputTensor.type;

    if (outputType == TensorType.float32) {
      final output = makeNestedList<double>(outputShape, 0.0);
      interpreter.run(modelInput, output);
      return flattenNested<double>(output);
    }
    if (outputType == TensorType.uint8) {
      final output = makeNestedList<int>(outputShape, 0);
      interpreter.run(modelInput, output);
      final flat = flattenNested<int>(output);
      return flat.map((e) => e / 255.0).toList(growable: false);
    }

    return null;
  }

  Future<FoodClassification?> classifyJpeg(Uint8List jpegBytes) async {
    final scores = _runOnJpeg(jpegBytes);
    if (scores == null || scores.isEmpty) return null;

    var bestIdx = 0;
    var bestScore = -double.infinity;
    for (var idx = 0; idx < scores.length; idx++) {
      final s = scores[idx];
      if (s > bestScore) {
        bestScore = s;
        bestIdx = idx;
      }
    }

    final labels = _labels;
    final label = bestIdx < labels.length ? labels[bestIdx] : 'class_$bestIdx';
    final confidence = bestScore.isFinite ? bestScore : 0.0;

    return FoodClassification(
      label: label,
      confidence: confidence.clamp(0, 1),
      index: bestIdx,
    );
  }

  Future<List<FoodClassification>> classifyTopKJpeg(
    Uint8List jpegBytes, {
    int k = 5,
  }) async {
    final scores = _runOnJpeg(jpegBytes);
    if (scores == null || scores.isEmpty) return const [];

    final preds = topK(scores, k: k);
    return [
      for (final p in preds)
        FoodClassification(
          label: p.label,
          confidence: p.confidence.clamp(0, 1),
          index: p.index,
        ),
    ];
  }

  List<FoodClassification> topK(List<double> scores, {int k = 5}) {
    final indices = List<int>.generate(scores.length, (i) => i);
    indices.sort((a, b) => scores[b].compareTo(scores[a]));

    final out = <FoodClassification>[];
    for (var n = 0; n < math.min(k, indices.length); n++) {
      final idx = indices[n];
      final label = idx < _labels.length ? _labels[idx] : 'class_$idx';
      out.add(FoodClassification(label: label, confidence: scores[idx], index: idx));
    }
    return out;
  }
}
