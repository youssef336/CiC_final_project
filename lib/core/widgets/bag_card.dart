// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'package:mysterybag/features/home/presentation/views/bagel_mystery_bag_screen.dart';
import 'package:mysterybag/generated/l10n.dart';

class BagCard extends StatelessWidget {
  final String title;
  final double price;
  final double oldPrice;
  final int bagsLeft;
  final double rating;
  final double width;

  final BagItemModel? bagItemModel;
  const BagCard({
    super.key,
    required this.width,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.bagsLeft,
    required this.rating,
    required this.bagItemModel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const ratingBadgeColor = Color(0xFFF3E7D2);
    const ratingTextColor = Color(0xFFB89A68);

    // Debug: log when a bag card is built to observe bagsLeft
    try {
      print('🧾 BagCard build: $title bagsLeft=$bagsLeft width=$width');
    } catch (_) {}

    return Container(
      width: width,

      margin: const EdgeInsets.only(left: 6, top: 3, right: 6, bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.24)
                : Colors.black.withOpacity(0.08),
            blurRadius: 18,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: isDark ? KdarkModeTextColor : KlightModeTextColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: ratingBadgeColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: ratingTextColor,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: ratingTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            '${oldPrice.toStringAsFixed(1)} ${S.of(context)!.bagCurrencySuffix}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? KdarkModeTextSecondary
                  : Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.6),
            ),
          ),

          const SizedBox(height: 0),

          Text(
            '${price.toStringAsFixed(1)} ${S.of(context)!.bagCurrencySuffix}',
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xFF4CAF50),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            S.of(context)!.bagCardBagsLeft(bagsLeft.toString()),
            style: const TextStyle(
              color: Color(0xFFC6A56A),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                final product = bagItemModel?.product;
                if (product == null) {
                  return;
                }

                Navigator.of(context).pushNamed(
                  BagelMysteryBagScreen.routeName,
                  arguments: {
                    'product': product,
                    'restaurant': bagItemModel?.restaurant,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC79E68),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                S.of(context)!.bagCardReserve,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
