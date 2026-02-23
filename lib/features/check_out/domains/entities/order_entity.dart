import 'package:mysterybag/features/check_out/domains/entities/shiping_address_entity.dart';
import 'package:mysterybag/features/home/domain/entities/cart_entites.dart';

class OrderEntity {
  final String uID;
  final CartEntites cartEntites;
  bool? payWithCash;

  // final List<NotificationEntity>? notificationEntity;
  ShipingAddressEntity shipingAddressEntity = ShipingAddressEntity();
  double appliedDiscount = 0; // internal discount state

  OrderEntity({
    // required this.notificationEntity,
    required this.cartEntites,
    this.payWithCash,
    required this.uID,
  });

  // void applyCouponCode(String code) {
  //   // Reset discount at the start
  //   List<String> coponCode = [];
  //   for (final notification in notificationEntity!) {
  //     coponCode.add(notification.code);
  //   }

  // appliedDiscount = 0;

  // If no notifications or empty list, nothing to apply
  // if (notificationEntity == null || notificationEntity!.isEmpty) return;

  // Check each notification for a matching code

  //   for (var copon in coponCode) {
  //     if (copon == code) {
  //       // Apply the discount
  //       appliedDiscount =
  //           calculateTotalPriceforCopon() *
  //           (notificationEntity![coponCode.indexOf(copon)].discount / 100);
  //       break;
  //     } else {
  //       // If no matching code, reset discount
  //       appliedDiscount = 0;
  //     }
  //   }
  // }

  double calculateShipingCost() {
    return (payWithCash ?? false) ? 40 : 0;
  }

  double calulateShipingDiscount() {
    return appliedDiscount;
  }

  double calculateTotalPriceforCopon() {
    return cartEntites.calculateTotalPrice() + calculateShipingCost();
  }

  double calculateTotalPriceAfterDiscountAndShiping() {
    return cartEntites.calculateTotalPrice() +
        calculateShipingCost() -
        calulateShipingDiscount();
  }
}
