// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mysterybag/core/errors/failures.dart';
import 'package:mysterybag/core/repos/product_repo/product_repo.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepo productRepo;
  StreamSubscription? _productsSubscription;

  ProductsCubit(this.productRepo) : super(ProductsInitial());

  Future<void> loadProducts({int? limit, String? restaurantId}) async {
    await _productsSubscription?.cancel();
    emit(ProductsLoading());
    try {
      if (limit != null) {
        final result = await productRepo.getProductsWithLimit(
          limit,
          restaurantId: restaurantId,
        );
        result.fold((failure) => emit(ProductsFailure(failure)), (products) {
          print(
            '📦 Products loaded: ${products.length} products (limit: $limit)',
          );
          emit(ProductsSuccess(products));
        });
        return;
      }

      _productsSubscription = productRepo
          .watchProducts(restaurantId: restaurantId)
          .listen((result) {
            result.fold((failure) => emit(ProductsFailure(failure)), (
              products,
            ) {
              print('📦 Products refreshed: ${products.length} products');
              for (final p in products) {
                try {
                  print(
                    '🔖 product documentId=${p.documentId} restaurantId=${p.restaurantId} title=${p.nameEn} bagsLeft=${p.bagsLeft}',
                  );
                } catch (_) {}
              }
              emit(ProductsSuccess(products));
            });
          });
    } catch (e) {
      print('❌ Error loading products: $e');
      emit(ProductsFailure(ServerFailure(e.toString())));
    }
  }

  @override
  Future<void> close() async {
    await _productsSubscription?.cancel();
    return super.close();
  }
}
