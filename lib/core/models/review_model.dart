import 'package:mysterybag/core/entities/review_entity.dart';

class ReviewModel {
  final String id;
  final String name;
  final String image;
  final num rating;
  final String review;
  final String date;

  ReviewModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.review,
    required this.date,
  });

  factory ReviewModel.fromEntity(ReviewEntity reviewEntity) => ReviewModel(
    id: reviewEntity.id,
    name: reviewEntity.name,
    image: reviewEntity.image,
    rating: reviewEntity.rating,
    review: reviewEntity.review,
    date: reviewEntity.date,
  );

  ReviewEntity toEntity() => ReviewEntity(
    id: id,
    name: name,
    image: image,
    rating: rating,
    review: review,
    date: date,
  );

  factory ReviewModel.fromJson(Map<String, dynamic> json, {String? id}) =>
      ReviewModel(
        id: id ?? json['id'] ?? '',
        name: json['name'],
        image: json['image'],
        rating: json['rating'],
        review: json['review'],
        date: json['date'],
      );

  Map<String, Object> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'rating': rating,
    'review': review,
    'date': date,
  };
}
