// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/features/check_out/domains/entities/order_entity.dart';

import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import 'shipinng_item.dart';

class ShipinngSection extends StatefulWidget {
  const ShipinngSection({super.key, required this.onSelectionChanged});
  final VoidCallback onSelectionChanged;

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
            widget.onSelectionChanged();
          },
          isSelected: selectedIndex == 0,
          title: S.of(context)!.checkOutViewShipingTitle1,
          subTitle: S.of(context)!.checkOutViewShipingSubtitle1,
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
                  text: S.of(context)!.checkOutViewShipingPrice,
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
            widget.onSelectionChanged();
          },
          isSelected: selectedIndex == 1,
          title: S.of(context)!.checkOutViewShipingTitle2,
          subTitle: S.of(context)!.checkOutViewShipingSubtitle2,
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
                  text: S.of(context)!.checkOutViewShipingPrice,
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
