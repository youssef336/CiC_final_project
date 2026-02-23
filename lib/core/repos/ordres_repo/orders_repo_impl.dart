import 'package:dartz/dartz.dart';
import 'package:mysterybag/core/errors/failures.dart';
import 'package:mysterybag/core/services/database_servies.dart';
import 'package:mysterybag/features/check_out/data/models/order_model.dart';
import 'package:mysterybag/features/check_out/domains/entities/order_entity.dart';

import '../../utils/back_end_endpoints.dart';
import 'orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseServies databaseServies;
  OrdersRepoImpl({required this.databaseServies});
  @override
  Future<Either<Failure, void>> addOrder({required OrderEntity order}) async {
    try {
      var orderModel = OrderModel.fromEntity(order);
      await databaseServies.addData(
        path: BackEndEndpoints.addOrder,
        documentId: orderModel.orderId,
        data: orderModel.toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
