// ignore_for_file: avoid_print

// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/helper_functions/build_error_bar.dart';
import 'package:mysterybag/core/services/shared_preferences_singletone.dart';
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
  final GlobalKey<FormState> _visaFormKey = GlobalKey<FormState>();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _addressEmailController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _addressCityController = TextEditingController();
  final TextEditingController _addressFloorController = TextEditingController();
  final TextEditingController _addressPhoneController = TextEditingController();

  @override
  void initState() {
    pageController = PageController(initialPage: 2);
    _loadSavedCardData();
    _loadSavedAddressData();

    pageController.addListener(() {
      setState(() {
        currentPageindex = pageController.page!.toInt();
      });
    });
    currentPageindex = 2;
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    valueNotifier.dispose();
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _addressNameController.dispose();
    _addressEmailController.dispose();
    _addressLineController.dispose();
    _addressCityController.dispose();
    _addressFloorController.dispose();
    _addressPhoneController.dispose();
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
              visaFormKey: _visaFormKey,
              cardHolderController: _cardHolderController,
              cardNumberController: _cardNumberController,
              expiryDateController: _expiryDateController,
              cvvController: _cvvController,
              onPaymentMethodChanged: () {
                if (mounted) {
                  setState(() {});
                }
              },
              onShippingMethodChanged: () {
                if (mounted) {
                  setState(() {});
                }
              },
              addressNameController: _addressNameController,
              addressEmailController: _addressEmailController,
              addressLineController: _addressLineController,
              addressCityController: _addressCityController,
              addressFloorController: _addressFloorController,
              addressPhoneController: _addressPhoneController,
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
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    );
  }

  String getNextButtonText(int currentPageindex) {
    final orderEntity = context.read<OrderEntity>();
    switch (currentPageindex) {
      case 0:
        return S.of(context)!.checkOutViewNext;
      case 1:
        return S.of(context)!.checkOutViewNext;
      case 2:
        if (orderEntity.payWithCash == true) {
          return S.of(context)!.checkOutViewPlaceOrder;
        }
        if (orderEntity.onlinePaymentMethod == 'visa') {
          return S.of(context)!.checkOutViewPayWithVisa;
        }
        return S.of(context)!.checkOutViewPayWithPayPal;
      default:
        return S.of(context)!.checkOutViewNext;
    }
  }

  void _handleAddressSectionValidation() {
    if (!_formKey.currentState!.validate()) {
      valueNotifier.value = AutovalidateMode.always;
      return;
    }
    _formKey.currentState!.save();
    _saveAddressLocally();
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _processPayment() {
    var orderEntity = context.read<OrderEntity>();
    var addOrder = context.read<OrderCubit>();

    if (orderEntity.payWithCash == true) {
      addOrder.addOrder(order: orderEntity);
      return;
    }

    if (orderEntity.onlinePaymentMethod == 'visa') {
      if (!_visaFormKey.currentState!.validate()) {
        showErrorBar(
          context,
          S.of(context)!.checkOutViewVisaValidationError,
        );
        return;
      }
      _saveVisaCardLocally(orderEntity);
      showErrorBar(
        context,
        S.of(context)!.checkOutViewVisaSavedSuccess,
      );
      addOrder.addOrder(order: orderEntity);
      return;
    }

    PaypalPaymentEntity paypalPaymentEntity = PaypalPaymentEntity.fromEntity(
      orderEntity,
    );

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
            showErrorBar(context, S.of(context)!.paymentSuccessMessage);
            addOrder.addOrder(order: orderEntity);
          },
          onError: (error) {
            print("onError: $error");
            showErrorBar(context, S.of(context)!.paymentErrorMessage);
            Navigator.pop(context);
          },
          onCancel: () {
            print('cancelled:');
          },
        ),
      ),
    );
  }

  void _loadSavedCardData() {
    _cardHolderController.text = Prefs.getString(KSavedCardHolderName);
    final savedLast4 = Prefs.getString(KSavedCardLast4);
    _cardNumberController.text = savedLast4.isEmpty
        ? ''
        : '**** **** **** $savedLast4';
    _expiryDateController.text = Prefs.getString(KSavedCardExpiryDate);
  }

  void _saveVisaCardLocally(OrderEntity orderEntity) {
    orderEntity.cardHolderName = _cardHolderController.text.trim();
    final digits = _cardNumberController.text
        .replaceAll(' ', '')
        .replaceAll('*', '');
    final savedLast4 = digits.isNotEmpty
        ? digits.substring(digits.length - 4)
        : Prefs.getString(KSavedCardLast4);
    orderEntity.cardNumber = savedLast4;
    orderEntity.expiryDate = _expiryDateController.text.trim();

    Prefs.setString(KSavedCardHolderName, orderEntity.cardHolderName!);
    Prefs.setString(KSavedCardLast4, orderEntity.cardNumber!);
    Prefs.setString(KSavedCardExpiryDate, orderEntity.expiryDate!);
  }

  void _loadSavedAddressData() {
    _addressNameController.text = Prefs.getString(KSavedAddressName);
    _addressEmailController.text = Prefs.getString(KSavedAddressEmail);
    _addressLineController.text = Prefs.getString(KSavedAddressLine);
    _addressCityController.text = Prefs.getString(KSavedAddressCity);
    _addressFloorController.text = Prefs.getString(KSavedAddressFloor);
    _addressPhoneController.text = Prefs.getString(KSavedAddressPhone);

    final orderEntity = context.read<OrderEntity>();
    orderEntity.shipingAddressEntity.name = _addressNameController.text;
    orderEntity.shipingAddressEntity.email = _addressEmailController.text;
    orderEntity.shipingAddressEntity.address = _addressLineController.text;
    orderEntity.shipingAddressEntity.city = _addressCityController.text;
    orderEntity.shipingAddressEntity.floor = _addressFloorController.text;
    orderEntity.shipingAddressEntity.phone = _addressPhoneController.text;
  }

  void _saveAddressLocally() {
    Prefs.setString(KSavedAddressName, _addressNameController.text.trim());
    Prefs.setString(KSavedAddressEmail, _addressEmailController.text.trim());
    Prefs.setString(KSavedAddressLine, _addressLineController.text.trim());
    Prefs.setString(KSavedAddressCity, _addressCityController.text.trim());
    Prefs.setString(KSavedAddressFloor, _addressFloorController.text.trim());
    Prefs.setString(KSavedAddressPhone, _addressPhoneController.text.trim());
  }
}
