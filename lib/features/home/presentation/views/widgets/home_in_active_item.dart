import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final unselected = Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
        scheme.onSurfaceVariant;

    return Container(
      height: 32,
      color: Colors.transparent,
      child: Center(
        child: SvgPicture.asset(
          imagePath,
          colorFilter: ColorFilter.mode(unselected, BlendMode.srcIn),
        ),
      ),
    );
  }
}
