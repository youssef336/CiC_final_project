import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mysterybag/core/utils/text_styles.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.text, required this.image});

  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pillBg = scheme.surfaceContainerHighest;
    final circleBg = scheme.primary;
    final circleFg = scheme.onPrimary;
    final labelColor = Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
        scheme.onSurfaceVariant;

    return Center(
      child: Container(
        decoration: ShapeDecoration(
          color: pillBg,
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
                color: circleBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  image,
                  colorFilter: ColorFilter.mode(circleFg, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: AppTextStyles.cairoBold.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: labelColor,
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
