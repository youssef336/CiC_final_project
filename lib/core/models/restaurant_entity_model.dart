class RestaurantEntity {
  final String name;
  final String foodImage;
  final String logoImage;
  final String branches;
  final String distance;
  final bool isAvailable;
  final bool isOpenNow;

  RestaurantEntity({
    required this.name,
    required this.foodImage,
    required this.logoImage,
    required this.branches,
    required this.distance,
    required this.isAvailable,
    required this.isOpenNow,
  });
}
