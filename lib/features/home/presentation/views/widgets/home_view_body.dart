import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/generated/l10n.dart';

import '../../../../../constant.dart';
import '../../../../../core/entities/demo_products.dart';
import '../../manager/cubits/cart/cart_cubit.dart';
import '../../../../food_scan/presentation/views/food_scan_view.dart';

import 'custom_home_appbar.dart';
import 'home_best_seller_header.dart';
import 'product_grid_view_bloc_builder.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    // Initialize products loading
    super.initState();
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
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.of(context).pushNamed(FoodScanView.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.qr_code_scanner_outlined),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                S.of(context)!.homeViewTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add demo products to cart
                    final cartCubit = context.read<CartCubit>();
                    for (var product in demoProducts) {
                      // Create a CartItem from each demo product with quantity 1
                      cartCubit.addProductToCart(product);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context)!.demoDataLoadedMessage),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: Text(S.of(context)!.loadDemoDataButton),
                ),

                const SizedBox(height: 12),
                const HomeBestSellerHeader(),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: ProductGridViewBlocBuilder()),
        ],
      ),
    );
  }
}
