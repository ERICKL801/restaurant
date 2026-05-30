import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../orders/data/datasources/orders_local_datasource.dart';
import '../../../orders/data/models/order_model.dart';
import '../../domain/entities/kitchen_order_entity.dart';
import '../../domain/entities/kitchen_order_item_entity.dart';
import '../../domain/enums/kitchen_order_status.dart';
import 'kitchen_datasource.dart';

final mockKitchenDatasourceProvider = Provider<KitchenDatasource>((ref) {
  final ordersDataSource = ref.watch(ordersLocalDataSourceProvider);
  return MockKitchenDatasource(ordersDataSource);
});

class MockKitchenDatasource implements KitchenDatasource {
  final OrdersLocalDataSource _ordersDataSource;

  MockKitchenDatasource(this._ordersDataSource);

  static const _kitchenStatuses = ['sent', 'preparing', 'ready', 'delivered'];

  @override
  Future<List<KitchenOrderEntity>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final orders = await _ordersDataSource.getOrdersByStatuses(_kitchenStatuses);
    return orders.map((o) => _mapToKitchenOrder(o)).toList();
  }

  @override
  Future<void> updateOrderStatus(
    String orderId,
    KitchenOrderStatus status,
  ) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final mappedStatus = _mapToOrderStatus(status);
    await _ordersDataSource.updateOrderStatus(
      orderId: orderId,
      status: mappedStatus,
    );
  }

  KitchenOrderEntity _mapToKitchenOrder(OrderModel order) {
    return KitchenOrderEntity(
      id: order.id,
      tableId: order.tableId,
      tableName: order.tableName,
      items: order.items
          .map((i) => KitchenOrderItemEntity(
                name: i.menuItem.name,
                quantity: i.quantity,
                note: i.note,
              ))
          .toList(),
      status: KitchenOrderStatus.fromString(order.status),
      createdAt: order.createdAt,
      total: order.items.fold(
        0.0,
        (sum, i) => sum + (i.menuItem.price * i.quantity),
      ),
    );
  }

  String _mapToOrderStatus(KitchenOrderStatus status) {
    switch (status) {
      case KitchenOrderStatus.sent:
        return 'sent';
      case KitchenOrderStatus.preparing:
        return 'preparing';
      case KitchenOrderStatus.ready:
      case KitchenOrderStatus.delivered:
        return 'completed';
    }
  }
}
