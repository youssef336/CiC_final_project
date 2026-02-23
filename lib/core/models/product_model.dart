import 'package:mysterybag/core/entities/product_entity.dart';
import 'package:mysterybag/core/helper_functions/get_avg_rating.dart';

import 'review_model.dart';

class ProductModel {
  final String nameEn;
  final String nameAr;
  final String code;
  final String description;
  final num price;

  final bool isfeatured;
  final num sellingCount;
  String? imageurl;
  final int experationMonths;
  final bool isOrganic;
  final int numbersOfCalories;
  final num avgRating;
  final num ratingCount = 0;
  final int unitAmount;
  final List<ReviewModel> reviews;
  ProductModel({
    required this.nameEn,
    required this.nameAr,

    required this.code,
    required this.description,
    required this.experationMonths,
    required this.numbersOfCalories,
    required this.avgRating,
    required this.unitAmount,
    required this.sellingCount,
    required this.reviews,
    required this.price,
    required this.isOrganic,
    required this.isfeatured,
    this.imageurl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      nameEn: json['nameEn'],
      nameAr: json['nameAr'],
      code: json['code'],
      description: json['description'],
      experationMonths: json['experationMonths'],
      numbersOfCalories: json['numbersOfCalories'],
      unitAmount: json['unitAmount'],
      sellingCount: json['sellingCount'],
      reviews: json['reviews'] != null
          ? List<ReviewModel>.from(
              json['reviews'].map(
                (e) => ReviewModel.fromJson(e as Map<String, dynamic>),
              ),
            )
          : [],
      price: json['price'],
      isOrganic: json['isOrganic'],
      isfeatured: json['isfeatured'],
      imageurl: json['imageurl'],
      avgRating: getAvgRating(json['reviews']),
    );
  }

  // product_model.dart
  ProductEntity toEntity() {
    return ProductEntity(
      nameAr: nameAr,
      nameEn: nameEn,
      code: code,
      description: description,
      price: price,
      reviews: reviews.map((e) => e.toEntity()).toList(),
      expirationsMonths: experationMonths,
      numbersOfCalories: numbersOfCalories,
      unitAmount: unitAmount,
      isOrganic: isOrganic,
      isFeatured: isfeatured,
      imageUrl: imageurl,
    );
  }
}
