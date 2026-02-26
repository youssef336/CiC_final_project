import 'package:flutter/material.dart';

class StatusBadgesWidget extends StatelessWidget {
  final bool isAvailable;
  final bool isOpenNow;

  const StatusBadgesWidget({
    super.key,
    required this.isAvailable,
    required this.isOpenNow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isAvailable)
          _buildBadge(
            icon: Icons.check_circle,
            text: "Available",
            color: const Color(0xff2DBE60),
          ),

        const SizedBox(width: 10),

        if (isOpenNow)
          _buildBadge(
            icon: Icons.access_time,
            text: "Now",
            color: const Color(0xffFF8C32),
          ),
      ],
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
