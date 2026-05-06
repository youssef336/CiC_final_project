// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/entities/review_analytics_entity.dart';
import 'package:mysterybag/core/entities/review_entity.dart';
import 'package:mysterybag/core/entities/product_entity.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/features/home/presentation/manager/cubits/products/products_cubit.dart';
import 'package:mysterybag/features/home/presentation/manager/cubits/products/products_state.dart';
import 'package:mysterybag/features/home/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:mysterybag/features/home/domains/repos/product_reviews_repo.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/bagel_customer_reviews_section.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/review_composer_bottom_sheet.dart';
import 'package:mysterybag/generated/l10n.dart';

class BagelMysteryBagScreen extends StatefulWidget {
  static const String routeName = '/bagelMysteryBag';

  const BagelMysteryBagScreen({
    super.key,
    required this.product,
    this.restaurant,
  });

  final ProductEntity product;
  final RestaurantEntity? restaurant;

  @override
  State<BagelMysteryBagScreen> createState() => _BagelMysteryBagScreenState();
}

class _BagelMysteryBagScreenState extends State<BagelMysteryBagScreen> {
  bool _reserved = false;
  bool _isReserving = false;
  late final ProductReviewsRepo _reviewsRepo;
  String? _fetchedBranchLocation;
  bool _locationFetched = false;
  late int _currentBagsLeft;

  @override
  void initState() {
    super.initState();
    _reviewsRepo = getIt<ProductReviewsRepo>();
    _currentBagsLeft = widget.product.bagsLeft;
    _fetchRestaurantLocation();
  }

  int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  bool _matchesEmbeddedProduct(Map<String, dynamic> productData) {
    final currentDocumentId = widget.product.documentId.trim();
    final candidateIds = <String>{
      productData['docId']?.toString().trim() ?? '',
      productData['productId']?.toString().trim() ?? '',
      productData['documentId']?.toString().trim() ?? '',
      productData['id']?.toString().trim() ?? '',
    }..removeWhere((value) => value.isEmpty);

    // Debug: print candidate ids and current doc id
    try {
      print(
        '🔍 _matchesEmbeddedProduct: currentDocumentId="$currentDocumentId" candidateIds=$candidateIds title=${productData['title'] ?? productData['nameEn']}',
      );
    } catch (_) {}

    if (currentDocumentId.isNotEmpty &&
        candidateIds.contains(currentDocumentId)) {
      return true;
    }

    return false;
  }

  bool _matchesLiveProduct(ProductEntity product) {
    final currentDocumentId = widget.product.documentId.trim();
    final candidateDocumentIds = <String>{
      product.documentId.trim(),
      product.restaurantId?.trim() ?? '',
    }..removeWhere((value) => value.isEmpty);

    if (currentDocumentId.isNotEmpty &&
        candidateDocumentIds.contains(currentDocumentId)) {
      return true;
    }

    return false;
  }

  ProductEntity? _liveProductFromState(ProductsState state) {
    if (state is! ProductsSuccess) {
      return null;
    }

    for (final product in state.products) {
      if (_matchesLiveProduct(product)) {
        return product;
      }
    }

    return null;
  }

  int _bagsLeftFromState(ProductsState state) {
    return _liveProductFromState(state)?.bagsLeft ?? _currentBagsLeft;
  }

  Future<void> _fetchRestaurantLocation() async {
    if (_locationFetched) return;

    final restaurantId = widget.product.restaurantId;
    print('📍 DEBUG: restaurantId = $restaurantId');
    if (restaurantId == null || restaurantId.isEmpty) {
      print('📍 DEBUG: restaurantId is null or empty');
      _locationFetched = true;
      return;
    }

    try {
      final firestore = FirebaseFirestore.instance;
      final doc = await firestore
          .collection('resturants')
          .doc(restaurantId)
          .get();

      print('📍 DEBUG: doc.exists = ${doc.exists}');
      print('📍 DEBUG: doc.data() = ${doc.data()}');

      if (doc.exists) {
        final branchLocation = doc.data()?['branchLocation'] as String?;
        print('📍 DEBUG: branchLocation = "$branchLocation"');

        final products = List<dynamic>.from(
          doc.data()?['products'] as List? ?? [],
        );
        for (final productData in products) {
          if (productData is Map<String, dynamic> &&
              _matchesEmbeddedProduct(productData)) {
            _currentBagsLeft = _asInt(productData['bagsLeft']);
            print('📍 DEBUG: updated bagsLeft = $_currentBagsLeft');
            break;
          }
        }

        if (branchLocation != null && branchLocation.isNotEmpty) {
          setState(() {
            _fetchedBranchLocation = branchLocation;
            _locationFetched = true;
          });
          print('📍 DEBUG: Successfully set location');
          return;
        } else {
          print('📍 DEBUG: branchLocation is null or empty');
        }
      } else {
        print('📍 DEBUG: Restaurant document does not exist');
      }
    } catch (e, st) {
      print('📍 DEBUG: Error: $e\n$st');
    }

    setState(() {
      _locationFetched = true;
    });
  }

  bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Color _backgroundColor(BuildContext context) {
    return _isDark(context) ? KdarkModeBgColor : KlightModeBgColor;
  }

  Color _cardColor(BuildContext context) {
    return _isDark(context) ? KdarkModeCardColor : KlightModeCardColor;
  }

  Color _primaryTextColor(BuildContext context) {
    return _isDark(context) ? KdarkModeTextColor : KlightModeTextColor;
  }

  Color _secondaryTextColor(BuildContext context) {
    return _isDark(context) ? KdarkModeTextSecondary : KlightModeTextSecondary;
  }

  String _productTitle(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl
        ? widget.product.nameAr
        : widget.product.nameEn;
  }

  String _restaurantName(BuildContext context) {
    final restaurantName = widget.product.restaurantName?.trim();
    if (restaurantName != null && restaurantName.isNotEmpty) {
      return restaurantName;
    }

    return S.of(context)!.bagelMysteryBagStoreName;
  }

  String _pickupTime(BuildContext context) {
    final pickupTime = widget.product.pickupTime?.trim();
    if (pickupTime != null && pickupTime.isNotEmpty) {
      return pickupTime;
    }

    return S.of(context)!.bagelMysteryBagPickupTimeValue;
  }

  String _ingredients(BuildContext context) {
    if (widget.product.detectedItems.isNotEmpty) {
      return widget.product.detectedItems.join(', ');
    }

    final description = widget.product.description.trim();
    if (description.isNotEmpty) {
      return description;
    }

    return S.of(context)!.bagelMysteryBagDescription;
  }

  String _locationValue(BuildContext context) {
    // Prefer the live branchLocation fetched from Firestore.
    print(
      '📍 _locationValue: _fetchedBranchLocation = "$_fetchedBranchLocation"',
    );
    if (_fetchedBranchLocation != null && _fetchedBranchLocation!.isNotEmpty) {
      print('📍 _locationValue: returning _fetchedBranchLocation');
      return _fetchedBranchLocation!;
    }

    // Fall back to the restaurant object only if the fetch did not populate.
    final restaurantLocation = widget.restaurant?.location?.trim();
    print('📍 _locationValue: restaurantLocation = "$restaurantLocation"');
    if (restaurantLocation != null && restaurantLocation.isNotEmpty) {
      print('📍 _locationValue: returning restaurantLocation');
      return restaurantLocation;
    }

    print('📍 _locationValue: returning fallback');
    return S.of(context)!.bagelMysteryBagLocationValue;
  }

  String _contactValue() {
    return '+201111303553';
  }

  double _currentPrice() {
    return widget.product.price.toDouble();
  }

  double _oldPrice() {
    return widget.product.oldPrice > 0
        ? widget.product.oldPrice.toDouble()
        : widget.product.price.toDouble();
  }

  Future<void> _reserveProduct(int bagsLeft) async {
    if (_isReserving || _reserved || bagsLeft <= 0) {
      return;
    }

    final restaurantId = widget.product.restaurantId;
    if (restaurantId == null || restaurantId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restaurant data is missing.')),
      );
      return;
    }

    setState(() {
      _isReserving = true;
    });

    try {
      final firestore = FirebaseFirestore.instance;
      final restaurantDoc = firestore
          .collection('resturants')
          .doc(restaurantId);

      await firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(restaurantDoc);
        if (!snapshot.exists) {
          throw StateError('Restaurant document not found');
        }

        final data = snapshot.data();
        final products = List<dynamic>.from(data?['products'] as List? ?? []);

        // First try exact id match against docId/productId/documentId
        final currentId = widget.product.documentId.trim();
        int productIndex = -1;
        if (currentId.isNotEmpty) {
          productIndex = products.indexWhere((productData) {
            if (productData is! Map) return false;
            final pd = Map<String, dynamic>.from(productData);
            final candidateIds = <String>{
              pd['docId']?.toString().trim() ?? '',
              pd['productId']?.toString().trim() ?? '',
              pd['documentId']?.toString().trim() ?? '',
              pd['id']?.toString().trim() ?? '',
            }..removeWhere((v) => v.isEmpty);
            final match = candidateIds.contains(currentId);
            if (match) {
              try {
                print(
                  '✅ reserve exact-id matched product: docId=$currentId title=${pd['title'] ?? pd['nameEn']} bagsLeft=${pd['bagsLeft']}',
                );
              } catch (_) {}
            }
            return match;
          });
        }

        if (productIndex == -1) {
          throw StateError('Product not found inside restaurant document');
        }

        final productMap = Map<String, dynamic>.from(
          products[productIndex] as Map,
        );
        final currentBagsLeft = _asInt(productMap['bagsLeft']);
        if (currentBagsLeft <= 0) {
          throw StateError('Sold out');
        }

        productMap['bagsLeft'] = currentBagsLeft - 1;
        products[productIndex] = productMap;

        transaction.update(restaurantDoc, {'products': products});
      });

      if (!mounted) {
        return;
      }

      context.read<CartCubit>().addProductToCart(widget.product);
      setState(() {
        _currentBagsLeft = bagsLeft > 0 ? bagsLeft - 1 : 0;
        _reserved = true;
      });

      await context.read<ProductsCubit>().loadProducts();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)!.bagelMysteryBagReservedState)),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _isReserving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final bagsLeft = _bagsLeftFromState(state);

        return Scaffold(
          backgroundColor: _backgroundColor(context),
          body: Stack(
            children: [
              // Scrollable content
              CustomScrollView(
                slivers: [
                  // Hero Image Section
                  SliverToBoxAdapter(
                    child: _buildHeroSection(context, bagsLeft),
                  ),

                  // White Card Content
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _cardColor(context),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      transform: Matrix4.translationValues(0, -24, 0),
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),

                          _buildStoreHeader(),
                          const SizedBox(height: 24),
                          _buildPriceBox(context, bagsLeft),
                          const SizedBox(height: 28),
                          _buildWhatsInBag(),
                          _buildDivider(),
                          _buildInfoRow(
                            icon: Icons.access_time_rounded,
                            iconBg: KsecondaryColor.withOpacity(0.7),
                            label: S
                                .of(context)!
                                .bagelMysteryBagPickupTimeLabel,
                            value: _pickupTime(context),
                            hasArrow: false,
                          ),
                          _buildDivider(),
                          _buildInfoRow(
                            icon: Icons.location_on_rounded,
                            iconBg: KsecondaryColor.withOpacity(0.7),
                            label: S.of(context)!.bagelMysteryBagLocationLabel,
                            value: _locationValue(context),
                            hasArrow: true,
                          ),
                          _buildDivider(),
                          _buildInfoRow(
                            icon: Icons.phone_rounded,
                            iconBg: KsecondaryColor.withOpacity(0.7),
                            label: S.of(context)!.bagelMysteryBagContactLabel,
                            value: _contactValue(),
                            hasArrow: true,
                          ),
                          _buildDivider(),
                          const SizedBox(height: 8),
                          _buildAllergens(),
                          _buildDivider(),
                          const SizedBox(height: 8),
                          BagelCustomerReviewsSection(
                            productId: widget.product.documentId,
                            reviewsRepo: _reviewsRepo,
                            onWriteReviewPressed: _showReviewComposer,
                            currentUserId:
                                FirebaseAuth.instance.currentUser?.uid ?? '',
                            onEditReview: _editReview,
                            onDeleteReview: _deleteReview,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Fixed Reserve Button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildReserveButton(bagsLeft),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context, int bagsLeft) {
    final locale = S.of(context)!;
    final heroImage = widget.product.imageUrl.trim();

    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: heroImage.isEmpty
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [KprimaryColor, KprimaryColorDark, KaccentColor],
                    )
                  : null,
              image: heroImage.isEmpty
                  ? null
                  : DecorationImage(
                      image: heroImage.startsWith('http')
                          ? NetworkImage(heroImage)
                          : AssetImage(heroImage),
                      fit: BoxFit.cover,
                    ),
            ),
            child: heroImage.isEmpty
                ? const SizedBox.expand()
                : Container(color: Colors.black.withOpacity(0.25)),
          ),

          // Decorative bagel circles removed

          // Back button
          PositionedDirectional(
            top: MediaQuery.of(context).padding.top + 12,
            start: 16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _cardColor(context).withOpacity(0.92),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: IconTheme(
                  data: IconThemeData(
                    size: 20,
                    color: _isDark(context)
                        ? KdarkModeTextColor
                        : KprimaryColor,
                  ),
                  child: const BackButtonIcon(),
                ),
              ),
            ),
          ),

          // Badges
          PositionedDirectional(
            top: MediaQuery.of(context).padding.top + 12,
            end: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBadge(
                  label: locale.bagelMysteryBagPickupOnlyBadge,
                  outlined: true,
                ),
                const SizedBox(height: 8),
                _buildBadge(
                  label: locale.bagCardBagsLeft(bagsLeft.toString()),
                  filled: true,
                ),
                const SizedBox(height: 8),
                _buildBadge(
                  label: locale.restaurantDistanceKilometers('2.2'),
                  outlined: false,
                  light: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Decorative bagel decorations removed as requested.

  Widget _buildBadge({
    required String label,
    bool outlined = false,
    bool filled = false,
    bool light = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: filled
            ? (_isDark(context) ? KaccentColor : KprimaryColor)
            : light
            ? (_isDark(context) ? KdarkModeCardColor : KsecondaryColor)
            : _cardColor(context),
        border: outlined ? Border.all(color: KaccentColor, width: 2) : null,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: filled
              ? Colors.white
              : (outlined ? KaccentColor : _primaryTextColor(context)),
        ),
      ),
    );
  }

  Widget _buildStoreHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // Logo
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [KprimaryColorLight, KsecondaryColor],
            ),
            border: Border.all(color: KdividerColor),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                widget.product.restaurantImageUrl ??
                    widget.restaurant?.logoImage ??
                    'https://via.placeholder.com/150',

                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _restaurantName(context),
                style: TextStyle(
                  fontSize: 13,
                  color: _secondaryTextColor(context),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _productTitle(context),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _primaryTextColor(context),
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        StreamBuilder<ReviewAnalyticsEntity>(
          stream: _reviewsRepo.watchProductReviewAnalytics(
            productId: widget.product.documentId,
          ),
          initialData: ReviewAnalyticsEntity(
            productId: widget.product.documentId,
            reviewCount: 0,
            averageRating: widget.product.avgRating,
            ratingBreakdown: const {},
          ),
          builder: (context, snapshot) {
            final averageRating =
                snapshot.data?.averageRating ?? widget.product.avgRating;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: KsecondaryColor,
                border: Border.all(color: KaccentColor.withOpacity(0.25)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star_rounded, color: KaccentColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: KaccentColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPriceBox(BuildContext context, int bagsLeft) {
    final locale = S.of(context)!;
    final currentPrice = _currentPrice();
    final oldPrice = _oldPrice();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: KdividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                locale.bagDetailsPriceLabel.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _secondaryTextColor(context),
                  letterSpacing: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: KaccentColor.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "-53%",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: KaccentColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text:
                  '${currentPrice.toStringAsFixed(0)} ${locale.bagCurrencySuffix}',
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${oldPrice.toStringAsFixed(0)} ${locale.bagCurrencySuffix}',
            style: TextStyle(
              fontSize: 16,
              color: _secondaryTextColor(context),
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const Divider(height: 28, color: KdividerColor),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                locale.bagelMysteryBagAvailableCount(bagsLeft.toString()),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _primaryTextColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsInBag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context)!.bagDetailsWhatInsideTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: _primaryTextColor(context),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _ingredients(context),
          style: TextStyle(
            fontSize: 15,
            color: _secondaryTextColor(context),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconBg,
    required String label,
    required String value,
    required bool hasArrow,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: KprimaryColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _secondaryTextColor(context),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _primaryTextColor(context),
                  ),
                ),
              ],
            ),
          ),
          if (hasArrow)
            Icon(Icons.chevron_right, color: _secondaryTextColor(context)),
        ],
      ),
    );
  }

  Widget _buildAllergens() {
    final locale = S.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.bagelMysteryBagIngredientsAndAllergens.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: _secondaryTextColor(context),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _backgroundColor(context),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: KdividerColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: KdividerColor, width: 2),
                ),
                child: Center(
                  child: Text(
                    "?",
                    style: TextStyle(
                      color: _secondaryTextColor(context),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  locale.bagelMysteryBagAllergenNotice,
                  style: TextStyle(
                    fontSize: 14,
                    color: _secondaryTextColor(context),
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildCustomerReviews() {
    final locale = S.of(context)!;
    final productId = widget.product.documentId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              color: _secondaryTextColor(context),
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              locale.bagelMysteryBagCustomerReviews,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: _primaryTextColor(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        StreamBuilder<List<ReviewEntity>>(
          stream: _reviewsRepo.watchProductReviews(productId: productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _backgroundColor(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: KdividerColor),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _backgroundColor(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: KdividerColor),
                ),
                child: Center(
                  child: Text(
                    'Error loading reviews',
                    style: TextStyle(color: _secondaryTextColor(context)),
                  ),
                ),
              );
            }

            final reviews = snapshot.data ?? [];

            if (reviews.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _backgroundColor(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: KdividerColor),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.rate_review_outlined,
                        color: _secondaryTextColor(context),
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No reviews yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _primaryTextColor(context),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Be the first to share your experience!',
                        style: TextStyle(
                          fontSize: 13,
                          color: _secondaryTextColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                ...reviews.map((review) => _buildReviewCard(review)),
                const SizedBox(height: 12),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(ReviewEntity review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: KdividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: review.image.isNotEmpty
                    ? NetworkImage(review.image)
                    : null,
                child: review.image.isEmpty
                    ? Icon(
                        Icons.person,
                        color: _secondaryTextColor(context),
                        size: 20,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _primaryTextColor(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: KaccentColor,
                            size: 14,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          review.date,
                          style: TextStyle(
                            fontSize: 12,
                            color: _secondaryTextColor(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.review.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.review,
              style: TextStyle(
                fontSize: 14,
                color: _primaryTextColor(context),
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showReviewComposer() async {
    final submitted = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewComposerBottomSheet(
        productId: widget.product.documentId,
        reviewsRepo: _reviewsRepo,
      ),
    );

    if (submitted == true && mounted) {
      await context.read<ProductsCubit>().loadProducts();
    }
  }

  Future<void> _editReview(ReviewEntity review) async {
    // Add current user ID to the review for editing
    final reviewWithUserId = review.copyWith(
      userId: FirebaseAuth.instance.currentUser?.uid,
    );

    final submitted = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewComposerBottomSheet(
        productId: widget.product.documentId,
        reviewsRepo: _reviewsRepo,
        existingReview: reviewWithUserId,
      ),
    );

    if (submitted == true && mounted) {
      await context.read<ProductsCubit>().loadProducts();
    }
  }

  void _deleteReview(String reviewId) async {
    final locale = S.of(context)!;
    final result = await _reviewsRepo.deleteProductReview(
      productId: widget.product.documentId,
      reviewId: reviewId,
    );

    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${locale.reviewComposerDeleteError}: ${failure.message}',
              ),
            ),
          );
        }
      },
      (_) {
        if (mounted) {
          context.read<ProductsCubit>().loadProducts();
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(locale.reviewComposerDeleteSuccess)),
          );
        }
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: KdividerColor);
  }

  Widget _buildReserveButton(int bagsLeft) {
    final locale = S.of(context)!;
    final isSoldOut = bagsLeft <= 0;
    final canReserve = !_reserved && !_isReserving && !isSoldOut;
    final buttonLabel = _isReserving
        ? (Directionality.of(context) == TextDirection.rtl
              ? 'جارٍ الحجز...'
              : 'Reserving...')
        : _reserved
        ? locale.bagelMysteryBagReservedState
        : isSoldOut
        ? (Directionality.of(context) == TextDirection.rtl
              ? 'نفدت الكمية'
              : 'Sold out')
        : locale.bagDetailsReservePickup;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            _cardColor(context),
            _cardColor(context),
            Colors.transparent,
          ],
        ),
      ),
      child: GestureDetector(
        onTap: canReserve ? () => _reserveProduct(bagsLeft) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: _reserved
                ? KaccentColor
                : isSoldOut
                ? Colors.grey
                : KprimaryColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: KdividerColor, width: 1),
          ),
          child: Center(
            child: Text(
              buttonLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
