import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mysterybag/features/check_out/domains/entities/order_entity.dart';
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
    final order = context.watch<OrderEntity>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
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
