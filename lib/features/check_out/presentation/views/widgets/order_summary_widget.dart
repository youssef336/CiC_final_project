import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/features/check_out/presentation/views/widgets/payment_item.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../domains/entities/order_entity.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentItem(
      title: S.of(context).OrderSummaryWidget_title,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                S.of(context).OrderSummaryWidget_subtotal,
                style: AppTextStyles.cairoRegular.copyWith(
                  color: const Color(0xFF4E5556),
                ),
              ),
              const Spacer(),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: context
                          .read<OrderEntity>()
                          .cartEntites
                          .calculateTotalPrice()
                          .toString(),
                      style: AppTextStyles.bodyBaseSemibold.copyWith(
                        color: const Color(0xFF0C0D0D),
                      ),
                    ),
                    TextSpan(
                      text: S.of(context).CheckOutView_Shipinng_price,
                      style: AppTextStyles.bodyBaseSemibold.copyWith(
                        color: const Color(0xFF0C0D0D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Text(
                S.of(context).OrderSummaryWidget_shipping,
                style: AppTextStyles.cairoRegular.copyWith(
                  color: const Color(0xFF4E5556),
                ),
              ),
              const Spacer(),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: context
                          .read<OrderEntity>()
                          .calculateShipingCost()
                          .toString(),
                      style: AppTextStyles.cairoRegular.copyWith(
                        color: const Color(0xFF4E5556),
                      ),
                    ),
                    TextSpan(
                      text: S.of(context).CheckOutView_Shipinng_price,
                      style: AppTextStyles.cairoRegular.copyWith(
                        color: const Color(0xFF4E5556),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),

          Visibility(
            visible: context.read<OrderEntity>().appliedDiscount != 0,
            child: Row(
              children: [
                Text(
                  "discount :",
                  style: AppTextStyles.cairoRegular.copyWith(
                    color: const Color(0xFF4E5556),
                  ),
                ),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "-",

                        style: AppTextStyles.cairoRegular.copyWith(
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: context
                            .read<OrderEntity>()
                            .appliedDiscount
                            .toString(),

                        style: AppTextStyles.cairoRegular.copyWith(
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: S.of(context).CheckOutView_Shipinng_price,
                        style: AppTextStyles.cairoRegular.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFFCACECE), indent: 32, endIndent: 32),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                S.of(context).OrderSummaryWidget_total,
                style: AppTextStyles.cairoBold.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF0C0D0D),
                ),
              ),
              const Spacer(),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: context
                          .read<OrderEntity>()
                          .calculateTotalPriceAfterDiscountAndShiping()
                          .toString(),
                      style: AppTextStyles.cairoBold.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF0C0D0D),
                      ),
                    ),
                    TextSpan(
                      text: S.of(context).CheckOutView_Shipinng_price,
                      style: AppTextStyles.cairoBold.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF0C0D0D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
