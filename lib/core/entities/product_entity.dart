// product_entity.dart

// ignore_for_file: unused_import, must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mysterybag/core/entities/review_entity.dart';

class ProductEntity extends Equatable {
  final String nameEn;
  final String nameAr;

  final String code;
  final String description;
  final num price;

  final bool isFeatured;
  String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic;
  final int numbersOfCalories;
  final num avgRating = 0;
  final num ratingCount = 0;
  final int unitAmount;
  final List<ReviewEntity> reviews;
  bool isFavorite = false; // Managed by FavoriteProvider

  ProductEntity({
    required this.nameEn,
    required this.nameAr,
    required this.code,
    required this.description,
    required this.price,
    required this.reviews,
    required this.expirationsMonths,
    required this.numbersOfCalories,
    required this.unitAmount,
    this.isOrganic = false,
    required this.isFeatured,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [code, nameAr, nameEn];
}
