// product_entity.dart

// ignore_for_file: unused_import, must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mysterybag/core/entities/review_entity.dart';

class ProductEntity extends Equatable {
  final String documentId;
  final String nameEn;
  final String nameAr;

  final String code;
  final String description;
  final num price;
  final num oldPrice;
  final int bagsLeft;
  final String? restaurantName;
  final String? pickupTime;
  final List<String> detectedItems;
  final String? userEmail;
  final String? restaurantId;
  final String? restaurantImageUrl;

  final bool isFeatured;
  String? imageUrl;
  final int expirationsMonths;
  final bool isOrganic;
  final int numbersOfCalories;
  final num avgRating;
  final num ratingCount = 0;
  final int unitAmount;
  final List<ReviewEntity> reviews;
  bool isFavorite = false; // Managed by FavoriteProvider

  ProductEntity({
    this.documentId = '',
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
    this.oldPrice = 0,
    this.bagsLeft = 0,
    this.restaurantName,
    this.pickupTime,
    this.detectedItems = const [],
    this.userEmail,
    this.restaurantId,
    this.restaurantImageUrl,
    this.avgRating = 0,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
    documentId,
    restaurantId,
    code,
    nameAr,
    nameEn,
    bagsLeft,
    avgRating,
    price,
    oldPrice,
  ];
}
