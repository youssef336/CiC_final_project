// ignore_for_file: unchecked_use_of_nullable_value

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysterybag/core/helper_functions/get_user.dart';
import 'package:mysterybag/core/services/get_it_service.dart';
import 'package:mysterybag/features/check_out/presentation/manager/cubits/order_cubit/order_cubit.dart';
import 'package:mysterybag/features/home/domain/entities/cart_entites.dart';
import 'package:mysterybag/generated/l10n.dart';

import 'package:provider/provider.dart';

import '../../../../core/repos/ordres_repo/orders_repo.dart';
import '../../../../core/widgets/build_app_bar.dart';
import '../../domains/entities/order_entity.dart';
import 'widgets/check_out_view_body.dart';
import 'widgets/order_cubit_bloc_consumer.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({
    super.key,
    required this.cartItems,
    // required this.notificationEntity,
  });
  static const String routeName = '/CheckOutView';
  final CartEntites cartItems;
  // final List<NotificationEntity>? notificationEntity;
  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  late OrderEntity orderEntity;
  @override
  void initState() {
    super.initState();
    orderEntity = OrderEntity(
      // notificationEntity: widget.notificationEntity,
      uID: getUser().id,
      cartEntites: widget.cartItems,
    );

    // Log the notification status for debugging
    // if (widget.notificationEntity == null) {
    //   debugPrint('No notification available for this order');
    // } else {
    //   debugPrint(
    //     'Using notification with code: ${widget.notificationEntity!.indexed}',
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(getIt.get<OrdersRepo>()),
      child: Scaffold(
        appBar: buildAppbar(
          context,
          title: S.of(context)!.checkOutViewTitle,
          showNotification: false,
        ),
        body: Provider.value(
          value: orderEntity,
          child: const OrderCubitBlocConsumer(child: CheckOutViewBody()),
        ),
      ),
    );
  }
}
