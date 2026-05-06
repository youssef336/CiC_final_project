import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/entities/product_entity.dart';
import 'package:mysterybag/core/models/bag_item_model.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'package:mysterybag/core/repos/product_repo/product_repo.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/core/widgets/available_bags_list.dart';
import 'package:mysterybag/core/widgets/resturant_card.dart';
import '../../manager/cubits/products/products_cubit.dart';
import '../../manager/cubits/products/products_state.dart';
import '../../../../../constant.dart';
import 'package:mysterybag/generated/l10n.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  late final ProductsCubit _productsCubit;

  @override
  void initState() {
    super.initState();
    _productsCubit = ProductsCubit(getIt<ProductRepo>());
    _productsCubit.loadProducts();
  }

  @override
  void dispose() {
    _productsCubit.close();
    super.dispose();
  }

  List<BagItemModel> _buildBags(
    BuildContext context,
    List<ProductEntity> products,
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

  ProductEntity? _firstProduct(List<ProductEntity> products) {
    if (products.isEmpty) {
      return null;
    }

    return products.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productsCubit,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KhorzontalPadding),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      final products = state is ProductsSuccess
                          ? state.products
                          : <ProductEntity>[];
                      final product = _firstProduct(products);
                      final bags = products.isNotEmpty
                          ? _buildBags(context, products)
                          : _defaultBags(context);

                      return Column(
                        children: [
                          const SizedBox(height: KTopPadding),
                          RestaurantCard(
                            restaurant: RestaurantEntity(
                              name:
                                  product?.restaurantName?.trim().isNotEmpty ==
                                      true
                                  ? product!.restaurantName!.trim()
                                  : S.of(context)!.restaurantNameMadbinaZamalek,
                              foodImage:
                                  product?.imageUrl?.trim().isNotEmpty == true
                                  ? product!.imageUrl!.trim()
                                  : 'assets/images/food.png',
                              logoImage: 'assets/images/resturant.png',
                              branches: S
                                  .of(context)!
                                  .restaurantBranchesCount('1'),
                              distance: S
                                  .of(context)!
                                  .restaurantDistanceKilometers('2.7'),
                              isAvailable: true,
                              isOpenNow: true,
                            ),
                          ),
                          const SizedBox(height: 20),
                          AvailableBagsList(
                            title: S.of(context)!.availableBagsTitle,
                            bags: bags,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
