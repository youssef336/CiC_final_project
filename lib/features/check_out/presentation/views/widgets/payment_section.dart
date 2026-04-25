import 'package:flutter/material.dart';
import 'package:mysterybag/core/utils/text_styles.dart';
import 'package:mysterybag/features/check_out/domains/entities/checkout_payment_method.dart';
import 'package:mysterybag/features/check_out/domains/entities/order_entity.dart';
import 'package:mysterybag/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'address_summary_widget.dart';
import 'online_payment_method_section.dart';
import 'order_summary_widget.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
    required this.pageController,
    required this.visaFormKey,
    required this.cardHolderController,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cvvController,
    required this.onPaymentMethodChanged,
  });
  final PageController pageController;
  final GlobalKey<FormState> visaFormKey;
  final TextEditingController cardHolderController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final VoidCallback onPaymentMethodChanged;

  @override
  Widget build(BuildContext context) {
    final order = context.read<OrderEntity>();
    final visaSelected = order.paymentMethod == CheckoutPaymentMethod.visa;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          if (visaSelected)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                S.of(context)!.paymentSectionVisaHint,
                textAlign: TextAlign.center,
                style: AppTextStyles.cairoRegular.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: 13,
                ),
              ),
            ),
          const OrderSummaryWidget(),
          if (order.payWithCash != true) ...[
            const SizedBox(height: 16),
            OnlinePaymentMethodSection(
              visaFormKey: visaFormKey,
              cardHolderController: cardHolderController,
              cardNumberController: cardNumberController,
              expiryDateController: expiryDateController,
              cvvController: cvvController,
              onPaymentMethodChanged: onPaymentMethodChanged,
            ),
          ],
          const SizedBox(height: 16),
          AddressSummaryWidget(pageController: pageController),
        ],
      ),
    );
  }
}
