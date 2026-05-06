import 'package:dartz/dartz.dart';
import 'package:mysterybag/core/entities/product_entity.dart';
import 'package:mysterybag/core/errors/failures.dart';
import 'package:mysterybag/core/models/product_model.dart';
import 'package:mysterybag/core/repos/product_repo/product_repo.dart';
import 'package:mysterybag/core/services/database_servies.dart';
import 'package:mysterybag/core/utils/back_end_endpoints.dart';

class ProductRepoImpl extends ProductRepo {
  final DatabaseServies databaseServies;

  ProductRepoImpl(this.databaseServies);
  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProduct() async {
    try {
      var data =
          await databaseServies.getData(
                path: BackEndEndpoints.getProducts,
                query: {
                  'limit': 6,
                  'orderBy': 'sellingCount',
                  'descending': true,
                },
              )
              as List<Map<String, dynamic>>;

      List<ProductEntity> products = data
          .map((e) => ProductModel.fromJson(e).toEntity())
          .toList();
      return right(products);
    } catch (e, st) {
      print('Error in getBestSellingProduct: $e\n$st');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      var data =
          await databaseServies.getData(path: BackEndEndpoints.getProducts)
              as List<Map<String, dynamic>>;
      List<ProductModel> products = data
          .map((e) => ProductModel.fromJson(e))
          .toList();
      List<ProductEntity> productsEntity = products
          .map((e) => e.toEntity())
          .toList();

      return right(productsEntity);
    } catch (e, st) {
      print('Error in getProducts: $e\n$st');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>>
  getBestSellingProductMoreLimit() async {
    try {
      var data =
          await databaseServies.getData(
                path: BackEndEndpoints.getProducts,
                query: {'orderBy': 'sellingCount', 'descending': true},
              )
              as List<Map<String, dynamic>>;

      List<ProductEntity> products = data
          .map((e) => ProductModel.fromJson(e).toEntity())
          .toList();
      return right(products);
    } catch (e, st) {
      print('Error in getBestSellingProductMoreLimit: $e\n$st');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
    String query,
  ) async {
    try {
      // First get all products
      final result = await getProducts();

      return result.fold((failure) => left(failure), (products) {
        // Filter products where nameEn or nameAr contains the query (case insensitive)
        final filteredProducts = products.where((product) {
          final queryLower = query.toLowerCase();
          return product.nameEn.toLowerCase().contains(queryLower) ||
              product.nameAr.toLowerCase().contains(queryLower);
        }).toList();

        return right(filteredProducts);
      });
    } catch (e) {
      return left(const ServerFailure('Failed to search products'));
    }
  }
}
