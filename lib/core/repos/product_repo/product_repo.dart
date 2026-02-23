import 'package:dartz/dartz.dart';
import 'package:mysterybag/core/entities/product_entity.dart';
import 'package:mysterybag/core/errors/failures.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProduct();
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProductMoreLimit();
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
}
