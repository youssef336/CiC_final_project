import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'bag_card.dart';

class AvailableBagsList extends StatelessWidget {
  final String title;
  final List<BagItemModel> bags;

  const AvailableBagsList({
    super.key,
    required this.title,
    required this.bags,
  });

  @override
  Widget build(BuildContext context) {
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
              const Text(
                "Swipe →",
                style: TextStyle(
                  color:KprimaryColor,
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
                rating: bag.rating, bagItemModel: null,
              );
            },
          ),
        ),
      ],
    );
  }
}

