import 'package:mysterybag/core/entities/review_entity.dart';

class ReviewModel {
  final String name;
  final String image;
  final num rating;
  final String review;
  final String date;

  ReviewModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.review,
    required this.date,
  });

  factory ReviewModel.fromEntity(ReviewEntity reviewEntity) => ReviewModel(
    name: reviewEntity.name,
    image: reviewEntity.image,
    rating: reviewEntity.rating,
    review: reviewEntity.review,
    date: reviewEntity.date,
  );
  ReviewEntity toEntity() => ReviewEntity(
    name: name,
    image: image,
    rating: rating,
    review: review,
    date: date,
  );
  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    name: json['name'],
    image: json['image'],
    rating: json['rating'],
    review: json['review'],
    date: json['date'],
  );
  Map<String, Object> toJson() => {
    'name': name,
    'image': image,
    'rating': rating,
    'review': review,
    'date': date,
  };
}
