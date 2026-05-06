// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:mysterybag/core/errors/failures.dart';
import 'package:mysterybag/core/repos/product_repo/product_repo.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepo productRepo;
  ProductsCubit(this.productRepo) : super(ProductsInitial());

  Future<void> loadProducts({int? limit, String? restaurantId}) async {
    emit(ProductsLoading());
    try {
      final result = limit != null
          ? await productRepo.getProductsWithLimit(
              limit,
              restaurantId: restaurantId,
            )
          : await productRepo.getProducts(restaurantId: restaurantId);
      result.fold((failure) => emit(ProductsFailure(failure)), (products) {
        print(
          '📦 Products loaded: ${products.length} products (limit: $limit)',
        );
        emit(ProductsSuccess(products));
      });
    } catch (e) {
      print('❌ Error loading products: $e');
      emit(ProductsFailure(ServerFailure(e.toString())));
    }
  }
}
