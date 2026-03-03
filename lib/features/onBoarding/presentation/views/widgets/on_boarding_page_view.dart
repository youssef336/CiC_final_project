// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:mysterybag/core/utils/assets.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/features/onBoarding/presentation/views/widgets/page_view_item.dart';
import 'package:mysterybag/generated/l10n.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    final assets = AssetsData.light();
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          isVisible: true,
          image: assets.images.onboardingImage_png,

          subtitle: S.of(context)!.onBoardingSubtitle,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context)!.onBoardingTitle,
                style: AppTextStyles.heading5Bold,
              ),
            ],
          ),
        ),
        PageViewItem(
          isVisible: false,
          image: assets.images.onboarding_image1_jpg,
          subtitle: S.of(context)!.onBoardingSubtitle2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context)!.onBoardingTitle2,
                style: AppTextStyles.heading5Bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
