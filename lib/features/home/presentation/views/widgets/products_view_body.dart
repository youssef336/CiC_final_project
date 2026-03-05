import 'package:flutter/material.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'package:mysterybag/core/widgets/available_bags_list.dart';
import 'package:mysterybag/core/widgets/resturant_card.dart';
import '../../../../../constant.dart';
import 'product_grid_view_bloc_builder.dart';

class ProductsViewBody extends StatelessWidget {
 ProductsViewBody({super.key});

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KhorzontalPadding),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: isDark ? KdarkModeBgColor : KlightModeBgColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Products',
              style: TextStyle(
                color: isDark ? KdarkModeTextColor : KlightModeTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                TextField(
                  onChanged: (query) {
                    // Handle search
                  },
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              RestaurantCard(restaurant: restaurant),
              const SizedBox(height: 20),
              AvailableBagsList(
                title: "Available bags",
                bags: bags,
              ),
              ProductGridViewBlocBuilder(),
              ],
            ),
          ),
           
        ],
      ),
    );
  }
}
