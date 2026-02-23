import 'package:flutter/material.dart';

class HomeBestSellerHeader extends StatelessWidget {
  const HomeBestSellerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Best Sellers',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C0D0D),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            // Navigate to best selling view
          },
          child: const Text(
            'View All',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF949D9E),
            ),
          ),
        ),
      ],
    );
  }
}
