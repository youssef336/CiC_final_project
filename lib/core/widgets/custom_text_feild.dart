import 'package:flutter/material.dart';

import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/generated/l10n.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.suffixIcon,
    this.onSaved,
    this.obscureText = false,
  });
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).on_signup_Text_feils;
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppTextStyles.bodysmallBold.copyWith(
          color: const Color(0xFF949D9E),
        ),

        filled: true,
        fillColor: const Color(0xFFF9FAFA),

        border: bulidBoarder(),
        enabledBorder: bulidBoarder(),
        focusedBorder: bulidBoarder(),
      ),

      onChanged: (value) {
        // Handle text input changes here
      },
    );
  }

  OutlineInputBorder bulidBoarder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFFE6E9E9), width: 1.0),
    );
  }
}

class CustomTextFormFeildforCopon extends StatelessWidget {
  const CustomTextFormFeildforCopon({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.suffixIcon,

    this.controller,
    this.obscureText = false,
    required this.textInputAction,
  });
  final String hintText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final Widget? suffixIcon;

  final bool obscureText;

  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,

      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppTextStyles.bodysmallBold.copyWith(
          color: const Color(0xFF949D9E),
        ),

        filled: true,
        fillColor: const Color(0xFFF9FAFA),

        border: bulidBoarder(),
        enabledBorder: bulidBoarder(),
        focusedBorder: bulidBoarder(),
      ),

      onChanged: (value) {
        // Handle text input changes here
      },
    );
  }

  OutlineInputBorder bulidBoarder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFFE6E9E9), width: 1.0),
    );
  }
}
