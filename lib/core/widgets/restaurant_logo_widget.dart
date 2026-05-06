import 'package:flutter/material.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';

class RestaurantLogoWidget extends StatelessWidget {
  final RestaurantEntity restaurant;
  const RestaurantLogoWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _getImageProvider(restaurant),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

ImageProvider _getImageProvider(RestaurantEntity restaurant) {
  print(
    '🖼️ RestaurantCard image: name=${restaurant.name}, restaurantImageUrl=${restaurant.restaurantImageUrl}, foodImage=${restaurant.foodImage}',
  );
  // Prioritize restaurantImageUrl from Firebase only if it's not a QR code
  if (restaurant.restaurantImageUrl?.isNotEmpty == true) {
    final url = restaurant.restaurantImageUrl!.trim();
    if (url.startsWith('http') && !url.toLowerCase().contains('qrcode')) {
      print('🖼️ Using NetworkImage from restaurantImageUrl: $url');
      return NetworkImage(url);
    }
  }

  // Fall back to foodImage (product image)
  if (restaurant.foodImage.startsWith('http')) {
    print('🖼️ Using NetworkImage from foodImage: ${restaurant.foodImage}');
    return NetworkImage(restaurant.foodImage);
  }
  print('🖼️ Using AssetImage: ${restaurant.foodImage}');
  return AssetImage(restaurant.foodImage);
}
