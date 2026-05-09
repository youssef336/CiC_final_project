// ignore_for_file: unchecked_use_of_nullable_value, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import '../../../../../core/services/shared_preferences_singletone.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/views/Sign_in_view.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.subtitle,
    required this.title,
    required this.isVisible,
  });

  final String image;
  final String subtitle;
  final Widget title;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight),
        child: IntrinsicHeight(
          child: Column(
            children: [
              /// 🔹 الصورة مع البلور
              SizedBox(
                height: screenHeight * 0.55,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Image.asset(image, fit: BoxFit.cover),
                    ),
                    Positioned.fill(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.38,
                      width: screenHeight * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 25,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(image, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              title,

              const SizedBox(height: 18),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyBaseSemibold.copyWith(
                    color: Colors.grey.shade700,
                    height: 1.6,
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KprimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Prefs.setBool(KisBoardingViewSeen, true);
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(SigninView.routeName);
                    },
                    child: Text(
                      S.of(context)!.onBoardingSkip,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
