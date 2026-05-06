import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/repos/product_repo/product_repo.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/features/home/presentation/manager/cubits/products/products_cubit.dart';
import 'package:mysterybag/generated/l10n.dart';
import 'package:mysterybag/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductsCubit(getIt<ProductRepo>())..loadProducts(restaurantLimit: 3),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context)!.homeViewTitle)),
        body: const HomeViewBody(),
      ),
    );
  }
}
