import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/entities/product_entity.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'package:mysterybag/generated/l10n.dart';

import '../../../../../constant.dart';
import '../../manager/cubits/products/products_cubit.dart';
import 'package:mysterybag/core/widgets/available_bags_list.dart';
import 'package:mysterybag/core/widgets/resturant_card.dart';

import 'custom_home_appbar.dart';
import '../../manager/cubits/products/products_state.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  List<BagItemModel> _buildBags(
    BuildContext context,
    List<ProductEntity> products,
    RestaurantEntity restaurant,
  ) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return products.map((product) {
      final title = isRtl ? product.nameAr : product.nameEn;
      final price = product.price.toDouble();
      final oldPrice = product.oldPrice > 0
          ? product.oldPrice.toDouble()
          : price;

      return BagItemModel(
        title: title,
        price: price,
        oldPrice: oldPrice,
        bagsLeft: product.bagsLeft,
        rating: product.avgRating.toDouble(),
        product: product,
        restaurant: restaurant,
      );
    }).toList();
  }

  List<BagItemModel> _defaultBags(BuildContext context) {
    return [
      BagItemModel(
        title: S.of(context)!.bagTitleAroussaSandwich,
        price: 50,
        oldPrice: 100,
        bagsLeft: 5,
        rating: 5,
      ),
      BagItemModel(
        title: S.of(context)!.bagTitleMasrawy,
        price: 60,
        oldPrice: 120,
        bagsLeft: 3,
        rating: 4.5,
      ),
    ];
  }

  List<_RestaurantProductsSection> _groupProductsByRestaurant(
    List<ProductEntity> products,
  ) {
    final groupedProducts = <String, _RestaurantProductsSection>{};

    for (final product in products) {
      final restaurantKey = _restaurantKey(product);
      print(
        '🏠 Grouping product ${product.nameEn}: restaurantImageUrl=${product.restaurantImageUrl}, imageUrl=${product.imageUrl}',
      );
      final section = groupedProducts.putIfAbsent(
        restaurantKey,
        () => _RestaurantProductsSection(
          restaurant: RestaurantEntity(
            name: product.restaurantName?.trim().isNotEmpty == true
                ? product.restaurantName!.trim()
                : S.of(context)!.restaurantNameMadbinaZamalek,
            foodImage: product.imageUrl.trim().isNotEmpty == true
              ? product.imageUrl.trim()
                : 'assets/images/food.png',
            logoImage: 'assets/images/resturant.png',
            branches: S.of(context)!.restaurantBranchesCount('1'),
            distance: S.of(context)!.restaurantDistanceKilometers('2.7'),
            location: S.of(context)!.bagelMysteryBagLocationValue,
            isAvailable: product.restaurantIsAvailable ?? true,
            isOpenNow: product.restaurantIsOpenNow ?? true,
            restaurantImageUrl:
                product.restaurantImageUrl?.trim().isNotEmpty == true
                ? product.restaurantImageUrl!.trim()
                : null,
          ),
        ),
      );
      section.products.add(product);
    }

    return groupedProducts.values.toList();
  }

  String _restaurantKey(ProductEntity product) {
    final restaurantId = product.restaurantId?.trim();
    if (restaurantId != null && restaurantId.isNotEmpty) {
      return restaurantId;
    }

    final restaurantName = product.restaurantName?.trim();
    if (restaurantName != null && restaurantName.isNotEmpty) {
      return restaurantName.toLowerCase();
    }

    return product.documentId.isNotEmpty ? product.documentId : product.code;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KhorzontalPadding),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const CustomHomeAppBar(),
                const SizedBox(height: KTopPadding),
                BlocConsumer<ProductsCubit, ProductsState>(
                  listener: (context, state) {
                    if (state is ProductsSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context)!.demoDataLoadedMessage,
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final products = state is ProductsSuccess
                        ? state.products
                        : <ProductEntity>[];

                    if (products.isEmpty && state is ProductsSuccess) {
                      return const Center(child: Text("لا يوجد منتجات متاحة"));
                    }

                    final restaurantSections = products.isNotEmpty
                        ? _groupProductsByRestaurant(products)
                        : <_RestaurantProductsSection>[];

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: restaurantSections.length,
                      itemBuilder: (context, index) {
                        final section = restaurantSections[index];
                        final bags = _buildBags(context, section.products, section.restaurant);

                        return Column(
                          children: [
                            RestaurantCard(restaurant: section.restaurant),
                            AvailableBagsList(
                              title: S.of(context)!.availableBagsTitle,
                              bags: bags,
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RestaurantProductsSection {
  _RestaurantProductsSection({required this.restaurant});

  final RestaurantEntity restaurant;
  final List<ProductEntity> products = <ProductEntity>[];

  String get foodImage {
    for (final product in products) {
      final imageUrl = product.imageUrl.trim();
      if (imageUrl.isNotEmpty) {
        return imageUrl;
      }
    }

    return 'assets/images/food.png';
  }
}
