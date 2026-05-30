import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/orders_local_datasource.dart';
import '../models/order_model.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl(ref.watch(ordersLocalDataSourceProvider));
});

class OrderRepositoryImpl implements OrderRepository {
  final OrdersLocalDataSource _dataSource;

  OrderRepositoryImpl(this._dataSource);

  @override
  Future<OrderEntity> createOrder(OrderEntity order) async {
    final model = await _dataSource.createOrder(
      OrderModel.fromEntity(order),
    );
    return model.toEntity();
  }

  @override
  Future<OrderEntity?> getOrderById(String orderId) async {
    final model = await _dataSource.getOrderById(orderId);
    return model?.toEntity();
  }

  @override
  Future<OrderEntity> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    final model = await _dataSource.updateOrderStatus(
      orderId: orderId,
      status: status.value,
    );
    return model.toEntity();
  }
}
