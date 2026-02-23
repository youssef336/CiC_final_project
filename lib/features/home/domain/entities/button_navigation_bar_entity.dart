import 'package:flutter/widgets.dart';
import 'package:mysterybag/core/utils/assets.dart';
import 'package:mysterybag/generated/l10n.dart';

class ButtonNavigationBarEntity {
  final String activeImagePath;
  final String inactiveImagePath;
  final String name;

  ButtonNavigationBarEntity({
    required this.activeImagePath,
    required this.inactiveImagePath,
    required this.name,
  });
}

List<ButtonNavigationBarEntity> getButtonNavigationBarItems(
  BuildContext context,
) {
  return [
    ButtonNavigationBarEntity(
      activeImagePath: AssetsData.light().images.bold.home_svg,
      inactiveImagePath: AssetsData.light().images.outline.home_svg,
      name: S.of(context).Button_NavigationBar_Entity_Home,
    ),
    ButtonNavigationBarEntity(
      activeImagePath: AssetsData.light().images.bold.products_svg,
      inactiveImagePath: AssetsData.light().images.outline.products_svg,
      name: S.of(context).Button_NavigationBar_Entity_Products,
    ),
    ButtonNavigationBarEntity(
      activeImagePath: AssetsData.light().images.bold.shopping_cart_svg,
      inactiveImagePath: AssetsData.light().images.outline.shopping_cart_svg,
      name: S.of(context).Button_NavigationBar_Entity_Cart,
    ),
    ButtonNavigationBarEntity(
      activeImagePath: AssetsData.light().images.bold.user_svg,
      inactiveImagePath: AssetsData.light().images.outline.user_svg,
      name: S.of(context).Button_NavigationBar_Entity_Profile,
    ),
  ];
}
