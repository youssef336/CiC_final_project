import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/bag_details_view.dart';

class BagCard extends StatelessWidget {
  final String title;
  final double price;
  final double oldPrice;
  final int bagsLeft;
  final double rating;

  final bagItemModel;
  const BagCard({
    super.key,
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
      width: 260,
      margin: const EdgeInsets.only(left: 6, top: 3, right: 6, bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // Shadow in all directions
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.shade300.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 2,
            offset: const Offset(0, 0),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? KdarkModeTextColor : KlightModeTextColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? KaccentColor.withOpacity(0.2)
                      : KaccentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: KaccentColor),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        color: isDark
                            ? KdarkModeTextColor
                            : KlightModeTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            "$oldPrice EGP",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: isDark
                  ? KdarkModeTextSecondary
                  : Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
            ),
          ),

          Text(
            "$price EGP",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const Spacer(),

          Text(
            "$bagsLeft Bags left",
            style: TextStyle(
              color: isDark ? KdarkModeTextSecondary : KaccentColor,
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BagDetailsView.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: KaccentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Reserve",
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
