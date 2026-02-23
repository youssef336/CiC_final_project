import 'package:dartz/dartz.dart';

import 'package:mysterybag/core/errors/failures.dart';

import '../../../features/check_out/domains/entities/order_entity.dart';

abstract class OrdersRepo {
  Future<Either<Failure, void>> addOrder({required OrderEntity order});
}
