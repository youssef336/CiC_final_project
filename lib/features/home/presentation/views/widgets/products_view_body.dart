import 'package:flutter/material.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'package:mysterybag/core/widgets/available_bags_list.dart';
import 'package:mysterybag/core/widgets/resturant_card.dart';
import 'package:mysterybag/generated/l10n.dart';
import '../../../../../constant.dart';
import 'product_grid_view_bloc_builder.dart';

class ProductsViewBody extends StatelessWidget {
  const ProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
              S.of(context)!.productsViewTitle,
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
                    hintText: S.of(context)!.searchProductsHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                RestaurantCard(restaurant: restaurant),
                const SizedBox(height: 20),
                AvailableBagsList(
                  title: S.of(context)!.availableBagsTitle,
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
