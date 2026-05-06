// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:mysterybag/core/errors/failures.dart';
import 'package:mysterybag/core/repos/product_repo/product_repo.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepo productRepo;
  ProductsCubit(this.productRepo) : super(ProductsInitial());

  Future<void> loadProducts() async {
    emit(ProductsLoading());
    try {
      final result = await productRepo.getProducts();
      result.fold((failure) => emit(ProductsFailure(failure)), (products) {
        emit(ProductsSuccess(products));
      });
    } catch (e) {
      emit(ProductsFailure(ServerFailure(e.toString())));
    }
  }
}
