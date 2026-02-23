import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';

class FeatureHomeItemButtom extends StatelessWidget {
  const FeatureHomeItemButtom({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: onPressed,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FittedBox(
            child: Text(
              'Shop Now',
              style: TextStyle(color: KprimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
