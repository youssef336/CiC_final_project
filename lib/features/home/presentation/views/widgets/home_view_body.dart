import 'package:flutter/material.dart';
import 'package:mysterybag/core/widgets/custom_buttom.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CustomButtom(text: 'add product', onPressed: () {})],
      ),
    );
  }
}
