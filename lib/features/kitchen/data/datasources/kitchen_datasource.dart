import '../../domain/entities/kitchen_order_entity.dart';
import '../../domain/enums/kitchen_order_status.dart';

abstract class KitchenDatasource {
  Future<List<KitchenOrderEntity>> getOrders();
  Future<void> updateOrderStatus(String orderId, KitchenOrderStatus status);
}
