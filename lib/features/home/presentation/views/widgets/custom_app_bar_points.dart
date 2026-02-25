import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/generated/l10n.dart';

class CustomappBarPoints extends StatelessWidget {
  const CustomappBarPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: KprimaryColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '250 ${S.of(context)!.homeViewAppbarPoint}',
              style: AppTextStyles.cairoRegular.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
