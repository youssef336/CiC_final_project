import 'package:flutter/material.dart';

import 'package:mysterybag/constant.dart';

import '../../../../../core/utils/text_styles.dart';

class ProfileViewItem extends StatelessWidget {
  const ProfileViewItem({
    super.key,
    required this.headText,
    required this.icon,
    required this.onPressed,
  });
  final String headText;
  final IconData icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const ShapeDecoration(shape: RoundedRectangleBorder()),
      child: Row(
        children: [
          Icon(icon, color: KprimaryColor, size: 26),
          const SizedBox(width: 7),
          Text(
            headText,
            style: AppTextStyles.bodyBaseSemibold.copyWith(
              color: const Color(0xFF949D9E),
            ),
          ),
          const Spacer(),

          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
