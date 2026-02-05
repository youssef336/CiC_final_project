import 'package:flutter/material.dart';

import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/generated/l10n.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 2, color: Colors.grey.shade400)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            S.of(context).on_Login_login_or_divider,
            style: AppTextStyles.bodyBaseSemibold,
          ),
        ),
        Expanded(child: Divider(thickness: 2, color: Colors.grey.shade400)),
      ],
    );
  }
}
