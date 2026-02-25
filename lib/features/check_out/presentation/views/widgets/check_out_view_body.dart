// ignore_for_file: avoid_print

// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import 'package:mysterybag/core/helper_functions/build_error_bar.dart';
import 'package:mysterybag/core/widgets/custom_buttom.dart';
import 'package:mysterybag/features/check_out/domains/entities/PaypalPaymentEntity/PaypalPaymentEntity.dart'
    show PaypalPaymentEntity;
import 'package:mysterybag/features/check_out/domains/entities/order_entity.dart';
import 'package:mysterybag/features/check_out/presentation/views/widgets/check_out_stage.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_key.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubits/order_cubit/order_cubit.dart';
import 'check_out_steps_page_view.dart';

class CheckOutViewBody extends StatefulWidget {
  const CheckOutViewBody({super.key});

  @override
  State<CheckOutViewBody> createState() => _CheckOutViewBodyState();
}

class _CheckOutViewBodyState extends State<CheckOutViewBody> {
  late PageController pageController;
  ValueNotifier<AutovalidateMode> valueNotifier = ValueNotifier(
    AutovalidateMode.disabled,
  );

  @override
  void initState() {
    pageController = PageController();

    pageController.addListener(() {
      setState(() {
        currentPageindex = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    valueNotifier.dispose();
    super.dispose();
  }

  int currentPageindex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CheckOutStage(
            onTap: (index) {
              if (index == 0) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                );
              } else if (index == 1) {
                var orderEntity = context.read<OrderEntity>().payWithCash;
                if (orderEntity != null) {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastOutSlowIn,
                  );
                } else {
                  showErrorBar(
                    context,
                    S.of(context)!.checkOutViewShipingError,
                  );
                }
              } else {
                _handleAddressSectionValidation();
              }
            },
            pageController: pageController,
            currentPageindex: currentPageindex,
          ),

          Expanded(
            child: CheckOutStepsPageView(
              autoValidateMode: valueNotifier,
              formKey: _formKey,
              pageController: pageController,
            ),
          ),
          CustomButtom(
            text: getNextButtonText(currentPageindex),
            onPressed: () {
              if (currentPageindex == 0) {
                _handleShipinngSectionValidation(context);
              } else if (currentPageindex == 1) {
                _handleAddressSectionValidation();
              } else {
                _processPayment();
                // var orderEntity = context.read<OrderEntity>();
                // context.read<OrderCubit>().addOrder(order: orderEntity);
              }
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _handleShipinngSectionValidation(BuildContext context) {
    if (context.read<OrderEntity>().payWithCash != null) {
      pageController.animateToPage(
        currentPageindex + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      showErrorBar(context, S.of(context)!.checkOutViewShipingError);
    }
  }

  String getNextButtonText(int currentPageindex) {
    switch (currentPageindex) {
      case 0:
        return S.of(context)!.checkOutViewNext;
      case 1:
        return S.of(context)!.checkOutViewNext;
      case 2:
        return S.of(context)!.checkOutViewPayWithPayPal;
      default:
        return S.of(context)!.checkOutViewNext;
    }
  }

  void _handleAddressSectionValidation() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      pageController.animateToPage(
        currentPageindex + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      valueNotifier.value = AutovalidateMode.always;
    }
  }

  void _processPayment() {
    var orderEntity = context.read<OrderEntity>();
    PaypalPaymentEntity paypalPaymentEntity = PaypalPaymentEntity.fromEntity(
      orderEntity,
    );
    var addOrder = context.read<OrderCubit>();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: KPaypalClientId,
          secretKey: KPaypalSecrtKey,
          transactions: [paypalPaymentEntity.toJson()],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            print("onSuccess: $params");
            Navigator.pop(context);
            showErrorBar(context, "تم الدفع بنجاح");
            addOrder.addOrder(order: orderEntity);
          },
          onError: (error) {
            print("onError: $error");
            showErrorBar(context, "حدث خطأ في الدفع");
            Navigator.pop(context);
          },
          onCancel: () {
            print('cancelled:');
          },
        ),
      ),
    );
  }
}
