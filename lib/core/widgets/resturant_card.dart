import 'package:flutter/material.dart';
import 'package:mysterybag/core/models/restaurant_entity_model.dart';
import 'status_badges_widget.dart';
import 'restaurant_logo_widget.dart';
import 'restaurant_info_widget.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 220,
      child: Stack(
        children: [

          /// Background Food Image
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              restaurant.foodImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          /// Gradient Overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
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
                      RestaurantLogoWidget(
                        imagePath: restaurant.logoImage,
                      ),
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
}
