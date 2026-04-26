import 'package:dartz/dartz.dart';
import 'package:mysterybag/core/entities/review_analytics_entity.dart';
import 'package:mysterybag/core/entities/review_entity.dart';
import 'package:mysterybag/core/errors/failures.dart';

abstract class ProductReviewsRepo {
  Stream<List<ReviewEntity>> watchProductReviews({required String productId});

  Stream<ReviewAnalyticsEntity> watchProductReviewAnalytics({
    required String productId,
  });

  Future<Either<Failure, void>> addProductReview({
    required String productId,
    required ReviewEntity review,
  });

  Future<Either<Failure, void>> updateProductReview({
    required String productId,
    required ReviewEntity review,
  });

  Future<Either<Failure, void>> deleteProductReview({
    required String productId,
    required String reviewId,
  });
}
