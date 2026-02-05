// ignore_for_file: non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';

import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/features/auth/presentation/views/sign_up_view.dart';
import 'package:mysterybag/generated/l10n.dart';

Text DontHaveAnAcoountWidget(BuildContext context) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: S.of(context).on_Login_create_account_text,
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
              Navigator.pushNamed(context, SignUpView.routeName);
            },
          text: S.of(context).on_Login_create_account,
          style: AppTextStyles.bodyBaseSemibold.copyWith(
            color: KprimaryColor /* Grayscale-600 */,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );
}
