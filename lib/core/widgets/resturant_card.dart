import 'package:flutter/material.dart';
import 'package:mysterybag/core/entities/product_entity.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'status_badges_widget.dart';
import 'restaurant_logo_widget.dart';
import 'restaurant_info_widget.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurant;
  ProductEntity? product;
  RestaurantCard({super.key, required this.restaurant, this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          /// Background Food Image
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(restaurant.foodImage),

                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// Gradient Overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          /// Content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusBadgesWidget(
                    isAvailable: restaurant.isAvailable,
                    isOpenNow: restaurant.isOpenNow,
                  ),

                  const Spacer(),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RestaurantLogoWidget(restaurant: restaurant),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RestaurantInfoWidget(
                          name: restaurant.name,
                          branches: restaurant.branches,
                          distance: restaurant.distance,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
}
