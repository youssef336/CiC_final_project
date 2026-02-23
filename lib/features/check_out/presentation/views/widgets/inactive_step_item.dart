import 'package:flutter/material.dart';
import 'package:mysterybag/core/utils/text_styles.dart';

class InactiveStepItem extends StatelessWidget {
  const InactiveStepItem({super.key, required this.text, required this.index});
  final String text;
  final String index;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: const Color(0xFFF2F3F3),
          child: Text(
            index,
            style: AppTextStyles.bodySmallSemibold.copyWith(height: 1.70),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.bodySmallSemibold.copyWith(
            color: const Color(0xFFAAAAAA),
            height: 1.70,
          ),
        ),
      ],
    );
  }
}
