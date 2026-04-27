import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? KaccentColor
        : Theme.of(context).primaryColor;
    final foregroundColor = isDark
        ? KprimaryColorDark
        : Theme.of(context).colorScheme.onPrimary;

    return SizedBox(
      height: 54,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
