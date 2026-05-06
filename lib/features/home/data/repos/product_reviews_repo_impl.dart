import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mysterybag/core/entities/review_analytics_entity.dart';
import 'package:mysterybag/core/entities/review_entity.dart';
import 'package:mysterybag/core/errors/exception.dart';
import 'package:mysterybag/core/errors/failures.dart';
import 'package:mysterybag/core/models/review_model.dart';
import 'package:mysterybag/core/utils/back_end_endpoints.dart';
import 'package:mysterybag/features/home/domains/repos/product_reviews_repo.dart';

class ProductReviewsRepoImpl implements ProductReviewsRepo {
  ProductReviewsRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _productDocument(String productId) {
    return _firestore.collection(BackEndEndpoints.getProducts).doc(productId);
  }

  List<ReviewEntity> _parseReviews(Map<String, dynamic>? productData) {
    if (productData == null) {
      return <ReviewEntity>[];
    }

    final reviewsData = productData['reviews'];
    if (reviewsData == null || reviewsData is! List) {
      return <ReviewEntity>[];
    }

    return reviewsData.map((reviewData) {
      if (reviewData is Map<String, dynamic>) {
        return ReviewModel.fromJson(reviewData).toEntity();
      }

      if (reviewData is Map) {
        return ReviewModel.fromJson(
          Map<String, dynamic>.from(reviewData),
        ).toEntity();
      }

      throw Exception('Invalid review data format');
    }).toList();
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> fetchProductReviews({
    required String productId,
  }) async {
    try {
      final snapshot = await _productDocument(productId).get();
      return Right(_parseReviews(snapshot.data()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to fetch reviews.'));
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Failed to fetch reviews.'));
    }
  }

  @override
  Stream<List<ReviewEntity>> watchProductReviews({required String productId}) {
    return _productDocument(productId).snapshots().map((snapshot) {
      try {
        return _parseReviews(snapshot.data());
      } catch (e) {
        print('Error processing reviews for productId $productId: $e');
        return <ReviewEntity>[];
      }
    });
  }

  @override
  Stream<ReviewAnalyticsEntity> watchProductReviewAnalytics({
    required String productId,
  }) {
    return watchProductReviews(productId: productId).map((reviews) {
      if (reviews.isEmpty) {
        return ReviewAnalyticsEntity.empty(productId: productId);
      }

      final ratingBreakdown = <int, int>{
        for (var rating = 1; rating <= 5; rating++) rating: 0,
      };

      num totalRating = 0;
      for (final review in reviews) {
        final roundedRating = review.rating.round().clamp(1, 5);
        ratingBreakdown[roundedRating] =
            (ratingBreakdown[roundedRating] ?? 0) + 1;
        totalRating += review.rating;
      }

      return ReviewAnalyticsEntity(
        productId: productId,
        reviewCount: reviews.length,
        averageRating: totalRating / reviews.length,
        ratingBreakdown: ratingBreakdown,
      );
    });
  }

  @override
  Future<Either<Failure, void>> addProductReview({
    required String productId,
    required ReviewEntity review,
  }) async {
    try {
      print('Adding review to product: $productId');
      final reviewToSave = ReviewModel.fromEntity(
        review.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString()),
      );

      print('Review data to save: ${reviewToSave.toJson()}');

      // First try to update, if the reviews field doesn't exist, create it
      try {
        await _productDocument(productId).update({
          'reviews': FieldValue.arrayUnion([reviewToSave.toJson()]),
        });
      } on FirebaseException catch (e) {
        if (e.code == 'not-found') {
          print('Product not found, trying to set reviews field directly');
          // If product doesn't exist or reviews field doesn't exist, try set
          await _productDocument(productId).set({
            'reviews': [reviewToSave.toJson()],
          }, SetOptions(merge: true));
        } else {
          rethrow;
        }
      }

      print('Review successfully added to product: $productId');
      return const Right(null);
    } on FirebaseException catch (e) {
      print('Firebase error adding review: ${e.code} - ${e.message}');
      return Left(ServerFailure(e.message ?? 'Failed to submit review.'));
    } on CustomException catch (e) {
      print('Custom error adding review: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('Unknown error adding review: $e');
      return const Left(ServerFailure('Failed to submit review.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProductReview({
    required String productId,
    required ReviewEntity review,
  }) async {
    try {
      final productDoc = await _productDocument(productId).get();
      final productData = productDoc.data();
      if (productData == null) {
        return const Left(ServerFailure('Product not found.'));
      }

      final reviewsList = List<Map<String, dynamic>>.from(
        productData['reviews'] as List<dynamic>? ?? [],
      );

      final reviewIndex = reviewsList.indexWhere((r) => r['id'] == review.id);

      if (reviewIndex != -1) {
        reviewsList[reviewIndex] = ReviewModel.fromEntity(review).toJson();
        await _productDocument(productId).update({'reviews': reviewsList});
      }

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to update review.'));
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Failed to update review.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProductReview({
    required String productId,
    required String reviewId,
  }) async {
    try {
      final productDoc = await _productDocument(productId).get();
      final productData = productDoc.data();
      if (productData == null) {
        return const Left(ServerFailure('Product not found.'));
      }

      final reviewsList = List<Map<String, dynamic>>.from(
        productData['reviews'] as List<dynamic>? ?? [],
      );

      reviewsList.removeWhere((r) => r['id'] == reviewId);

      await _productDocument(productId).update({'reviews': reviewsList});

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to delete review.'));
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Failed to delete review.'));
    }
  }
}
