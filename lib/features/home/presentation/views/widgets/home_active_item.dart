import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/utils/text_styles.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.text, required this.image});

  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFEEEEEE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                color: KprimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(child: SvgPicture.asset(image)),
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: AppTextStyles.cairoBold.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: KprimaryColorDark /* Green1-500 */,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
