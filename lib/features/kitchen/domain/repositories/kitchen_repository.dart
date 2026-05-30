import '../entities/kitchen_order_entity.dart';
import '../enums/kitchen_order_status.dart';

abstract class KitchenRepository {
  Future<List<KitchenOrderEntity>> getOrders();
  Future<void> updateOrderStatus(String orderId, KitchenOrderStatus status);
}
