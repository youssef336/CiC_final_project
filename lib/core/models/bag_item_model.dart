import 'package:mysterybag/core/entities/product_entity.dart';

class BagItemModel {
  final String title;
  final double price;
  final double oldPrice;
  final int bagsLeft;
  final double rating;
  final ProductEntity? product;

  BagItemModel({
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.bagsLeft,
    required this.rating,
    this.product,
  });
}
