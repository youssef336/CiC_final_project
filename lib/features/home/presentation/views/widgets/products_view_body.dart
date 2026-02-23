import 'package:flutter/material.dart';
import '../../../../../constant.dart';
import 'product_grid_view_bloc_builder.dart';

class ProductsViewBody extends StatelessWidget {
  const ProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KhorzontalPadding),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(title: Text('Products'), pinned: true),
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
              ],
            ),
          ),
          const ProductGridViewBlocBuilder(),
        ],
      ),
    );
  }
}
