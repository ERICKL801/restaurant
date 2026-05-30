import '../entities/order_entity.dart';
import '../enums/order_status.dart';

abstract class OrderRepository {
  Future<OrderEntity> createOrder(OrderEntity order);
  Future<OrderEntity?> getOrderById(String orderId);
  Future<OrderEntity> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  });
}
