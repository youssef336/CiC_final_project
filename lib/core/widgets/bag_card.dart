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

    return Container(
      width: width,
      margin: const EdgeInsets.only(left: 6, top: 3, right: 6, bottom: 10),
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: isDark ? KdarkModeTextColor : KlightModeTextColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F2E8),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: KaccentColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        color: isDark
                            ? KdarkModeTextColor
                            : KlightModeTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            '${oldPrice.toStringAsFixed(1)} ${S.of(context)!.bagCurrencySuffix}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? KdarkModeTextSecondary
                  : Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.6),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '${price.toStringAsFixed(1)} ${S.of(context)!.bagCurrencySuffix}',
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: Color(0xFF4CAF50),
            ),
          ),

          const Spacer(),

          Text(
            S.of(context)!.bagCardBagsLeft(bagsLeft.toString()),
            style: const TextStyle(
              color: Color(0xFFC6A56A),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                final product = bagItemModel?.product;
                if (product == null) {
                  return;
                }

                Navigator.of(context).pushNamed(
                  BagelMysteryBagScreen.routeName,
                  arguments: product,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC79E68),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
              ),
              child: Text(
                S.of(context)!.bagCardReserve,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
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
