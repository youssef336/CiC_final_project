// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysterybag/core/widgets/custom_text_feild.dart'
    show CustomTextFormFeild, CustomTextFormFeildforCopon;
import 'package:mysterybag/features/check_out/domains/entities/order_entity.dart';

import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';

class AddressInputSection extends StatelessWidget {
  AddressInputSection({
    super.key,
    required this.formKey,
    required this.autoValidateMode,
  });

  final GlobalKey<FormState> formKey;
  String? code;
  final ValueListenable<AutovalidateMode> autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<AutovalidateMode>(
        valueListenable: autoValidateMode,
        builder: (context, value, child) => Form(
          key: formKey,
          autovalidateMode: value,
          child: Column(
            children: [
              const SizedBox(height: 24),
              CustomTextFormFeild(
                onSaved: (value) {
                  context.read<OrderEntity>().shipingAddressEntity.name =
                      value!;
                },
                hintText: S.of(context).AddressInputSection_name,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormFeild(
                onSaved: (value) {
                  context.read<OrderEntity>().shipingAddressEntity.email =
                      value!;
                },
                hintText: S.of(context).AddressInputSection_email,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormFeild(
                onSaved: (value) {
                  context.read<OrderEntity>().shipingAddressEntity.address =
                      value!;
                },
                hintText: S.of(context).AddressInputSection_address,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormFeild(
                onSaved: (value) {
                  context.read<OrderEntity>().shipingAddressEntity.city =
                      value!;
                },
                hintText: S.of(context).AddressInputSection_city,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormFeild(
                onSaved: (value) {
                  context.read<OrderEntity>().shipingAddressEntity.floor =
                      value!;
                },
                hintText: S.of(context).AddressInputSection_floor,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormFeild(
                onSaved: (value) {
                  context.read<OrderEntity>().shipingAddressEntity.phone =
                      value!;
                },
                hintText: S.of(context).AddressInputSection_phone,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              MyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  MyWidget({super.key});
  final TextEditingController _controller = TextEditingController();

  void _applyCouponCode(BuildContext context, OrderEntity order, String code) {
    // order.applyCouponCode(code);
    final discount = order.calulateShipingDiscount();

    if (discount > 0) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Discount applied: $discount EGP"),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the text field
      _controller.clear();

      // Remove focus from the text field
      FocusScope.of(context).unfocus();
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid or expired coupon code"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = context.read<OrderEntity>();
    // final notification = order.notificationEntity;

    // Return empty SizedBox if no notification is available
    // if (notification == null) {
    //   return const SizedBox.shrink();
    // }

    // Only show the coupon input if there's a valid notification
    return Row(
      children: [
        Expanded(
          child: CustomTextFormFeildforCopon(
            controller: _controller,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            hintText: "Coupon code",

            suffixIcon: IconButton(
              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 28,
              ),
              onPressed: () {
                final code = _controller.text.trim();
                if (code.isNotEmpty) {
                  _applyCouponCode(context, order, code);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
