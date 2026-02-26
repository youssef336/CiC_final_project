import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'package:mysterybag/core/widgets/available_bags_list.dart';
import 'package:mysterybag/core/widgets/resturant_card.dart';

class ProductGridViewBlocBuilder extends StatelessWidget {
  ProductGridViewBlocBuilder({super.key});

  final restaurant = RestaurantEntity(
    name: "Madbina - Zamalek",
    foodImage: "assets/images/food.png",
    logoImage: "assets/images/resturant.png",
    branches: "1 branch",
    distance: "2.7 kilometers",
    isAvailable: true,
    isOpenNow: true,
  );

  final List<BagItemModel> bags = [
    BagItemModel(
      title: "Aroussa Sandwich Bag",
      price: 50,
      oldPrice: 100,
      bagsLeft: 5,
      rating: 5.0,
    ),
    BagItemModel(
      title: "Masrawy Bag",
      price: 60,
      oldPrice: 120,
      bagsLeft: 3,
      rating: 4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RestaurantCard(restaurant: restaurant),
        const SizedBox(height: 20),
        AvailableBagsList(title: "Available bags", bags: bags),
      ],
    );
  }
}
