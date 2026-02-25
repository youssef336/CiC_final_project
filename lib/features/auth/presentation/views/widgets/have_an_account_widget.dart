// ignore_for_file: non_constant_identifier_names

import 'package:flutter/gestures.dart';
// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/generated/l10n.dart';

Text HaveAnAcoountWidget(BuildContext context) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: S.of(context)!.onSignupCreateNewAccountText,
          style: AppTextStyles.bodyBaseSemibold.copyWith(
            color: const Color(0xFF949D9E) /* Grayscale-600 */,
          ),
        ),
        TextSpan(
          text: ' ',
          style: AppTextStyles.bodyBaseSemibold.copyWith(
            color: const Color(0xFF616A6B),
          ),
        ),

        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pop(context);
            },
          text: S.of(context)!.onSignupCreateNewAccountText2,
          style: AppTextStyles.bodyBaseSemibold.copyWith(
            color: KprimaryColor /* Grayscale-600 */,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );
}
