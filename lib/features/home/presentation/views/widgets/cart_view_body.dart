import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/constant.dart' show KTopPadding;
import 'package:mysterybag/core/widgets/build_app_bar.dart';
import 'package:mysterybag/features/home/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/cart_item_list.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/cart_view_header.dart';

import '../../../../../core/widgets/custom_divider.dart';
import '../../../../../generated/l10n.dart';
import 'custom_cart_buttom_bloc_builder.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  buildAppbar(
                    context,
                    title: S.of(context).CartViewHeader,
                    showNotification: false,
                    showBackButton: false,
                  ),
                  const SizedBox(height: KTopPadding),

                  const CartViewHeader(),
                  const SizedBox(height: 8),
                  // Use BlocBuilder here
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: context.read<CartCubit>().cartEntites.cartItems.isEmpty
                  ? const SizedBox()
                  : const CustomDivider(),
            ),
            CartItemList(
              cartItems: context.watch<CartCubit>().cartEntites.cartItems,
            ),
            SliverToBoxAdapter(
              child: context.read<CartCubit>().cartEntites.cartItems.isEmpty
                  ? const SizedBox()
                  : const CustomDivider(),
            ),
          ],
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).size.height * 0.07,
          child: Visibility(
            visible: context.read<CartCubit>().cartEntites.cartItems.isNotEmpty,
            child: const CustomCartButtomBlocBuilder(),
          ),
        ),
      ],
    );
  }
}
