import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysterybag/features/check_out/presentation/views/widgets/address_input_section.dart';
import 'package:mysterybag/features/check_out/presentation/views/widgets/payment_section.dart';
import 'package:mysterybag/features/check_out/presentation/views/widgets/shipinng_section.dart';

class CheckOutStepsPageView extends StatelessWidget {
  const CheckOutStepsPageView({
    super.key,
    required this.pageController,
    required this.formKey,
    required this.autoValidateMode,
  });

  final PageController pageController;
  final GlobalKey<FormState> formKey;

  final ValueListenable<AutovalidateMode> autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: getPages().length,
        itemBuilder: (context, index) {
          return getPages()[index];
        },
      ),
    );
  }

  List<Widget> getPages() {
    return [
      const ShipinngSection(),
      AddressInputSection(autoValidateMode: autoValidateMode, formKey: formKey),
      PaymentSection(pageController: pageController),
    ];
  }
}
