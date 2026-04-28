// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/entities/review_entity.dart';
import 'package:mysterybag/core/models/product_model.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/features/home/domains/repos/product_reviews_repo.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/bagel_customer_reviews_section.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/review_composer_bottom_sheet.dart';
import 'package:mysterybag/generated/l10n.dart';

class BagelMysteryBagScreen extends StatefulWidget {
  static const String routeName = '/bagelMysteryBag';

  const BagelMysteryBagScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<BagelMysteryBagScreen> createState() => _BagelMysteryBagScreenState();
}

class _BagelMysteryBagScreenState extends State<BagelMysteryBagScreen> {
  bool _reserved = false;
  late final ProductReviewsRepo _reviewsRepo;

  @override
  void initState() {
    super.initState();
    _reviewsRepo = getIt<ProductReviewsRepo>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor(context),
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            slivers: [
              // Hero Image Section
              SliverToBoxAdapter(child: _buildHeroSection(context)),

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
                      _buildPriceBox(),
                      const SizedBox(height: 28),
                      _buildWhatsInBag(),
                      _buildDivider(),
                      _buildInfoRow(
                        icon: Icons.access_time_rounded,
                        iconBg: KsecondaryColor.withOpacity(0.7),
                        label: S.of(context)!.bagelMysteryBagPickupTimeLabel,
                        value: S.of(context)!.bagelMysteryBagPickupTimeValue,
                        hasArrow: false,
                      ),
                      _buildDivider(),
                      _buildInfoRow(
                        icon: Icons.location_on_rounded,
                        iconBg: KsecondaryColor.withOpacity(0.7),
                        label: S.of(context)!.bagelMysteryBagLocationLabel,
                        value: S.of(context)!.bagelMysteryBagLocationValue,
                        hasArrow: true,
                      ),
                      _buildDivider(),
                      _buildInfoRow(
                        icon: Icons.phone_rounded,
                        iconBg: KsecondaryColor.withOpacity(0.7),
                        label: S.of(context)!.bagelMysteryBagContactLabel,
                        value: '+201111303553',
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
            child: _buildReserveButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final locale = S.of(context)!;

    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [KprimaryColor, KprimaryColorDark, KaccentColor],
              ),
            ),
          ),

          // Decorative bagel circles
          ..._buildBagelDecorations(),

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
                _buildBadge(label: locale.bagCardBagsLeft('3'), filled: true),
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

  List<Widget> _buildBagelDecorations() {
    final bagels = [
      {'top': 0.15, 'left': 0.08, 'size': 110.0},
      {'top': 0.04, 'left': 0.36, 'size': 130.0},
      {'top': 0.18, 'left': 0.60, 'size': 100.0},
    ];

    return bagels.map((b) {
      final size = b['size'] as double;
      return Positioned(
        top: 280 * (b['top'] as double),
        left: MediaQuery.of(context).size.width * (b['left'] as double),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              center: Alignment(-0.3, -0.3),
              colors: [KaccentColor, KprimaryColorDark],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: size * 0.35,
              height: size * 0.35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [KprimaryColorLight, KsecondaryColor],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

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
    final locale = S.of(context)!;

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
          child: const Center(
            child: Text(
              "G's",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: KprimaryColor,
                letterSpacing: -1,
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
                locale.bagelMysteryBagStoreName,
                style: TextStyle(
                  fontSize: 13,
                  color: _secondaryTextColor(context),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                locale.bagelMysteryBagTitle,
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: KsecondaryColor,
            border: Border.all(color: KaccentColor.withOpacity(0.25)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.star_rounded, color: KaccentColor, size: 16),
              SizedBox(width: 4),
              Text(
                "5.0",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: KaccentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBox() {
    final locale = S.of(context)!;

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
              children: [
                const TextSpan(
                  text: '35 ',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: locale.bagCurrencySuffix,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '75 ${locale.bagCurrencySuffix}',
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
                locale.bagelMysteryBagAvailableCount('3'),
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
    final locale = S.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.bagDetailsWhatInsideTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: _primaryTextColor(context),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          locale.bagelMysteryBagDescription,
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

  void _showReviewComposer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewComposerBottomSheet(
        productId: widget.product.documentId,
        reviewsRepo: _reviewsRepo,
      ),
    );
  }

  void _editReview(ReviewEntity review) {
    // Add current user ID to the review for editing
    final reviewWithUserId = review.copyWith(
      userId: FirebaseAuth.instance.currentUser?.uid,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewComposerBottomSheet(
        productId: widget.product.documentId,
        reviewsRepo: _reviewsRepo,
        existingReview: reviewWithUserId,
      ),
    );
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

  Widget _buildReserveButton() {
    final locale = S.of(context)!;

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
        onTap: () => setState(() => _reserved = !_reserved),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: _reserved ? KaccentColor : KprimaryColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: KdividerColor, width: 1),
          ),
          child: Center(
            child: Text(
              _reserved
                  ? locale.bagelMysteryBagReservedState
                  : locale.bagDetailsReservePickup,
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
