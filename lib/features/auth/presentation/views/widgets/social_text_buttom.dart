import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mysterybag/core/utils/text_styles.dart';

class SocialTextButtom extends StatelessWidget {
  const SocialTextButtom({
    super.key,
    this.onPressed,
    required this.image,
    required this.text,
  });
  final void Function()? onPressed;
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFDCDEDE), width: 1),
          ),
        ),
        onPressed: onPressed,

        child: ListTile(
          visualDensity: const VisualDensity(
            vertical: VisualDensity.minimumDensity,
          ),
          leading: SvgPicture.asset(image),
          title: Text(
            textAlign: TextAlign.center,
            text,
            style: AppTextStyles.bodyBaseSemibold.copyWith(
              color: const Color(0xFF0C0D0D),
            ),
          ),
        ),
      ),
    );
  }
}
