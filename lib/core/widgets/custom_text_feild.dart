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
          return S.of(context)!.onSignupTextFeils;
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppTextStyles.bodysmallBold.copyWith(
          color: Theme.of(context).hintColor,
        ),

        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,

        border: bulidBoarder(context),
        enabledBorder: bulidBoarder(context),
        focusedBorder: bulidBoarder(context),
      ),

      onChanged: (value) {
        // Handle text input changes here
      },
    );
  }

  OutlineInputBorder bulidBoarder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
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
          color: Theme.of(context).hintColor,
        ),

        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,

        border: bulidBoarder(context),
        enabledBorder: bulidBoarder(context),
        focusedBorder: bulidBoarder(context),
      ),

      onChanged: (value) {
        // Handle text input changes here
      },
    );
  }

  OutlineInputBorder bulidBoarder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
    );
  }
}
