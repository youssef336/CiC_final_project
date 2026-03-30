import 'package:flutter/material.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'package:mysterybag/core/widgets/available_bags_list.dart';
import 'package:mysterybag/core/widgets/resturant_card.dart';
import 'package:mysterybag/generated/l10n.dart';

class ProductGridViewBlocBuilder extends StatelessWidget {
  const ProductGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = RestaurantEntity(
      name: S.of(context)!.restaurantNameMadbinaZamalek,
      foodImage: 'assets/images/food.png',
      logoImage: 'assets/images/resturant.png',
      branches: S.of(context)!.restaurantBranchesCount('1'),
      distance: S.of(context)!.restaurantDistanceKilometers('2.7'),
      isAvailable: true,
      isOpenNow: true,
    );

    final List<BagItemModel> bags = [
      BagItemModel(
        title: S.of(context)!.bagTitleAroussaSandwich,
        price: 50,
        oldPrice: 100,
        bagsLeft: 5,
        rating: 5.0,
      ),
      BagItemModel(
        title: S.of(context)!.bagTitleMasrawy,
        price: 60,
        oldPrice: 120,
        bagsLeft: 3,
        rating: 4.5,
      ),
    ];

    return Column(
      children: [
        RestaurantCard(restaurant: restaurant),
        const SizedBox(height: 20),
        AvailableBagsList(title: S.of(context)!.availableBagsTitle, bags: bags),
      ],
    );
  }
}
