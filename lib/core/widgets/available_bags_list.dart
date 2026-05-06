import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'package:mysterybag/generated/l10n.dart';
import 'bag_card.dart';

class AvailableBagsList extends StatelessWidget {
  final String title;
  final List<BagItemModel> bags;

  const AvailableBagsList({super.key, required this.title, required this.bags});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                S.of(context)!.availableBagsSwipeHint,
                style: TextStyle(
                  color: isDark ? KaccentColor : KprimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        /// Horizontal List
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth * 0.78).clamp(260.0, 320.0);

            return SizedBox(
              height: 345,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bags.length,
                itemBuilder: (context, index) {
                  final bag = bags[index];

                  return BagCard(
                    width: cardWidth,
                    title: bag.title,
                    price: bag.price,
                    oldPrice: bag.oldPrice,
                    bagsLeft: bag.bagsLeft,
                    rating: bag.rating,
                    bagItemModel: bag,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
