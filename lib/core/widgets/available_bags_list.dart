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
          padding: const EdgeInsets.symmetric(horizontal: 4),
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

        const SizedBox(height: 12),

        /// Horizontal List
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth * 0.74).clamp(230.0, 280.0);

            return SizedBox(
              width: constraints.maxWidth,
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
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
