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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                S.of(context)!.availableBagsSwipeHint,
                style: TextStyle(
                  color: isDark ? KaccentColor : KprimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        /// Horizontal List
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bags.length,
            itemBuilder: (context, index) {
              final bag = bags[index];

              return BagCard(
                title: bag.title,
                price: bag.price,
                oldPrice: bag.oldPrice,
                bagsLeft: bag.bagsLeft,
                rating: bag.rating,
                bagItemModel: null,
              );
            },
          ),
        ),
      ],
    );
  }
}
