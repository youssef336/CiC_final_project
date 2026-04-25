// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/core/services/visa_card_prefs_services.dart';
import 'package:mysterybag/features/check_out/domains/entities/checkout_payment_method.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final m = context.read<OrderEntity>().paymentMethod;
      if (m != null) {
        setState(() {
          selectedIndex = m.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final order = context.read<OrderEntity>();
    final cartTotal = order.cartEntites.calculateTotalPrice();
    final codTotal = cartTotal + 40;
    return Column(
      children: [
        const SizedBox(height: 33),
        ShipinngItem(
          onTap: () {
            setState(() {
              selectedIndex = 0;
              order.paymentMethod = CheckoutPaymentMethod.cashOnDelivery;
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
                  text: codTotal.toString(),
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
              order.paymentMethod = CheckoutPaymentMethod.paypal;
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
                  text: cartTotal.toString(),
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
              selectedIndex = 2;
              order.paymentMethod = CheckoutPaymentMethod.visa;
            });
          },
          isSelected: selectedIndex == 2,
          title: S.of(context)!.checkOutViewShipingTitle3,
          subTitle: S.of(context)!.checkOutViewShipingSubtitle3,
          price: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: cartTotal.toString(),
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
        if (selectedIndex == 2 && VisaCardPrefsServices.hasSavedCard()) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    S.of(context)!.visaDetailsEndsWith(
                      VisaCardPrefsServices.loadCard()!.last4,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cairoRegular.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: S.of(context)!.visaDetailsDelete,
                  onPressed: () async {
                    await VisaCardPrefsServices.clearCard();
                    if (mounted) setState(() {});
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
