import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';

class HomeBestSellerHeader extends StatelessWidget {
  const HomeBestSellerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Text(
          'Best Sellers',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? KdarkModeTextColor : KlightModeTextColor,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            // Navigate to best selling view
          },
          child: Text(
            'View All',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? KdarkModeTextSecondary : KlightModeTextSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
