import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/generated/l10n.dart';

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
        _buildBadge(
          icon: isAvailable ? Icons.check_circle : Icons.cancel,
          text: isAvailable
              ? S.of(context)!.statusBadgeAvailable
              : S.of(context)!.statusBadgeUnavailable,
          color: isAvailable ? KaccentColor : Colors.redAccent,
        ),

        const SizedBox(width: 10),

        _buildBadge(
          icon: isOpenNow ? Icons.access_time : Icons.access_time_filled,
          text: isOpenNow
              ? S.of(context)!.statusBadgeNow
              : S.of(context)!.statusBadgeClosed,
          color: isOpenNow ? KprimaryColor : Colors.grey,
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
