import 'package:mysterybag/core/models/restaurant_entity_model.dart';

/// Demo restaurants for home page display
final List<RestaurantEntity> demoRestaurants = [
  RestaurantEntity(
    name: 'Madbina - Zamalek',
    foodImage: 'assets/images/food.png',
    logoImage: 'assets/images/resturant.png',
    branches: '1 branch',
    distance: '2.7 kilometers',
    isAvailable: true,
    isOpenNow: true,
  ),
  RestaurantEntity(
    name: 'Burger Palace',
    foodImage: 'assets/images/food.png',
    logoImage: 'assets/images/resturant.png',
    branches: '3 branches',
    distance: '1.5 kilometers',
    isAvailable: true,
    isOpenNow: true,
  ),
  RestaurantEntity(
    name: 'Pizza Corner',
    foodImage: 'assets/images/food.png',
    logoImage: 'assets/images/resturant.png',
    branches: '2 branches',
    distance: '3.2 kilometers',
    isAvailable: true,
    isOpenNow: false,
  ),
];
