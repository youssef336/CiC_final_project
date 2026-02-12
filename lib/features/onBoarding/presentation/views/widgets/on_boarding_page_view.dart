import 'package:flutter/material.dart';
import 'package:mysterybag/assets.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/features/onBoarding/presentation/views/widgets/page_view_item.dart';
import 'package:mysterybag/generated/l10n.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          isVisible: true,
          image: Assets.images.app_icon_jpg,
          backgroundimage: Assets.images.app_icon_jpg,
          subtitle: S.of(context).on_boarding_subtitle,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).on_boarding_title,
                style: AppTextStyles.heading5Bold,
              ),
            ],
          ),
        ),
        PageViewItem(
          isVisible: false,

          image: Assets.images.app_icon_jpg,
          backgroundimage: Assets.images.app_icon_jpg,
          subtitle: S.of(context).on_boarding_subtitle2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).on_boarding_title2,
                style: AppTextStyles.heading5Bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
