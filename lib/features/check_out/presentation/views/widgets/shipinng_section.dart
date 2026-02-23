import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/features/check_out/domains/entities/order_entity.dart';

import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import 'shipinng_item.dart';

class ShipinngSection extends StatefulWidget {
  const ShipinngSection({super.key});

  @override
  State<ShipinngSection> createState() => _ShipinngSectionState();
}

class _ShipinngSectionState extends State<ShipinngSection>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const SizedBox(height: 33),
        ShipinngItem(
          onTap: () {
            setState(() {
              selectedIndex = 0;
              context.read<OrderEntity>().payWithCash = true;
            });
          },
          isSelected: selectedIndex == 0,
          title: S.of(context).CheckOutView_Shipinng_title1,
          subTitle: S.of(context).CheckOutView_Shipinng_Subtitle1,
          price: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      (context
                                  .read<OrderEntity>()
                                  .cartEntites
                                  .calculateTotalPrice() +
                              40)
                          .toString(),
                  style: AppTextStyles.bodysmallBold.copyWith(
                    color: KprimaryColorLight,
                  ),
                ),
                TextSpan(
                  text: S.of(context).CheckOutView_Shipinng_price,
                  style: AppTextStyles.bodysmallBold.copyWith(
                    color: KprimaryColorLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ShipinngItem(
          onTap: () {
            setState(() {
              selectedIndex = 1;
              context.read<OrderEntity>().payWithCash = false;
            });
          },
          isSelected: selectedIndex == 1,
          title: S.of(context).CheckOutView_Shipinng_title2,
          subTitle: S.of(context).CheckOutView_Shipinng_Subtitle2,
          price: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: context
                      .read<OrderEntity>()
                      .cartEntites
                      .calculateTotalPrice()
                      .toString(),
                  style: AppTextStyles.bodysmallBold.copyWith(
                    color: KprimaryColorLight,
                  ),
                ),
                TextSpan(
                  text: S.of(context).CheckOutView_Shipinng_price,
                  style: AppTextStyles.bodysmallBold.copyWith(
                    color: KprimaryColorLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
