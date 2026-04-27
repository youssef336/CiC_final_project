import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/entities/review_entity.dart';
import 'package:mysterybag/features/home/domains/repos/product_reviews_repo.dart';
import 'package:mysterybag/generated/l10n.dart';

class BagelCustomerReviewsSection extends StatelessWidget {
  const BagelCustomerReviewsSection({
    super.key,
    required this.productId,
    required this.reviewsRepo,
    required this.onWriteReviewPressed,
  });

  final String productId;
  final ProductReviewsRepo reviewsRepo;
  final VoidCallback onWriteReviewPressed;

  bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
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

  Widget _buildActionButton(BuildContext context, String label) {
    final isDark = _isDark(context);

    return TextButton.icon(
      onPressed: onWriteReviewPressed,
      style: TextButton.styleFrom(
        backgroundColor: isDark
            ? KprimaryColorLight.withOpacity(0.12)
            : KprimaryColor.withOpacity(0.06),
        foregroundColor: isDark ? KprimaryColorLight : KprimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(
            color: isDark
                ? KprimaryColorLight.withOpacity(0.2)
                : KprimaryColor.withOpacity(0.12),
          ),
        ),
      ),
      icon: const Icon(Icons.edit_note_rounded, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: KaccentColor.withOpacity(_isDark(context) ? 0.18 : 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star_border_rounded,
                color: KaccentColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                locale.bagelMysteryBagCustomerReviews,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _primaryTextColor(context),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: _buildActionButton(context, locale.reviewComposerTitle),
            ),
          ],
        ),
        const SizedBox(height: 14),
        StreamBuilder<List<ReviewEntity>>(
          stream: reviewsRepo.watchProductReviews(productId: productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _cardColor(context),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: KdividerColor),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: _cardColor(context),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isDark(context)
                        ? Colors.white.withOpacity(0.08)
                        : KdividerColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        _isDark(context) ? 0.18 : 0.04,
                      ),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: KaccentColor.withOpacity(0.14),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: KaccentColor,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Error loading reviews',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: _primaryTextColor(context),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Pull to refresh or try again later.',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: _secondaryTextColor(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            final reviews = snapshot.data ?? [];
            final averageRating = reviews.isEmpty
                ? 0.0
                : reviews.fold<double>(
                        0,
                        (sum, review) => sum + review.rating.toDouble(),
                      ) /
                      reviews.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _cardColor(context),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isDark(context)
                          ? Colors.white.withOpacity(0.08)
                          : KdividerColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          _isDark(context) ? 0.16 : 0.04,
                        ),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              KaccentColor.withOpacity(0.18),
                              KprimaryColorLight.withOpacity(0.18),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            averageRating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: KaccentColor,
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
                              '${reviews.length} ${locale.bagelMysteryBagCustomerReviews}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: _primaryTextColor(context),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              locale.reviewComposerSubtitle,
                              style: TextStyle(
                                fontSize: 12.5,
                                height: 1.4,
                                color: _secondaryTextColor(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: _secondaryTextColor(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                if (reviews.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 22,
                    ),
                    decoration: BoxDecoration(
                      color: _cardColor(context),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _isDark(context)
                            ? Colors.white.withOpacity(0.08)
                            : KdividerColor,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  KaccentColor.withOpacity(0.18),
                                  KprimaryColorLight.withOpacity(0.14),
                                ],
                              ),
                            ),
                            child: Icon(
                              Icons.rate_review_outlined,
                              color: _isDark(context)
                                  ? KsecondaryColor
                                  : KprimaryColor,
                              size: 34,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'No reviews yet',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: _primaryTextColor(context),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Be the first to share your experience!',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.45,
                              color: _secondaryTextColor(context),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      ...reviews.map(
                        (review) => _buildReviewCard(context, review),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '?';
    }
    return (parts[0].isNotEmpty ? parts[0][0] : '') +
        (parts[1].isNotEmpty ? parts[1][0] : '');
  }

  Color _getAvatarColor(String name) {
    final colors = [
      KaccentColor,
      KprimaryColorLight,
      const Color(0xFF9C27B0),
      const Color(0xFF3F51B5),
      const Color(0xFF2196F3),
      const Color(0xFF00BCD4),
      const Color(0xFF009688),
    ];
    final hash = name.hashCode.abs();
    return colors[hash % colors.length];
  }

  Widget _buildReviewCard(BuildContext context, ReviewEntity review) {
    final avatarColor = _getAvatarColor(review.name);
    final surfaceColor = _cardColor(context);
    final borderColor = _isDark(context)
        ? Colors.white.withOpacity(0.08)
        : KdividerColor.withOpacity(0.75);

    return SizedBox(
      width: 300,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isDark(context) ? 0.16 : 0.04),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                gradient: LinearGradient(
                  colors: [
                    avatarColor,
                    avatarColor.withOpacity(0.55),
                    KaccentColor,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: avatarColor.withOpacity(0.45),
                            width: 1.4,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                avatarColor,
                                avatarColor.withOpacity(0.78),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _getInitials(review.name),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: _primaryTextColor(context),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              review.date,
                              style: TextStyle(
                                fontSize: 12,
                                color: _secondaryTextColor(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: KaccentColor.withOpacity(
                            _isDark(context) ? 0.2 : 0.14,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: KaccentColor,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              review.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: KaccentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (review.review.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                      decoration: BoxDecoration(
                        color: _isDark(context)
                            ? Colors.white.withOpacity(0.03)
                            : KlightModeBgColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _isDark(context)
                              ? Colors.white.withOpacity(0.05)
                              : KdividerColor,
                        ),
                      ),
                      child: Text(
                        review.review,
                        style: TextStyle(
                          fontSize: 13.5,
                          color: _primaryTextColor(context),
                          height: 1.65,
                        ),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
