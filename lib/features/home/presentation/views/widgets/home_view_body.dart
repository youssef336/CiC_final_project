import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constant.dart';
import '../../../../../core/entities/demo_products.dart';
import '../../manager/cubits/cart/cart_cubit.dart';

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
                ElevatedButton.icon(
                  onPressed: () {
                    // Add demo products to cart
                    final cartCubit = context.read<CartCubit>();
                    for (var product in demoProducts) {
                      // Create a CartItem from each demo product with quantity 1
                      cartCubit.addProductToCart(product);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Demo data loaded! Go to Cart to test checkout.',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Load Demo Data'),
                ),

                const SizedBox(height: 12),
                const HomeBestSellerHeader(),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const ProductGridViewBlocBuilder(),
        ],
      ),
    );
  }
}
