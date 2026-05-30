import '../enums/order_status.dart';
import 'order_item_entity.dart';

class OrderEntity {
  final String id;
  final String tableId;
  final String tableName;
  final DateTime createdAt;
  final OrderStatus status;
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.tableId,
    required this.tableName,
    required this.createdAt,
    this.status = OrderStatus.draft,
    this.items = const [],
  });

  double get total =>
      items.fold(0.0, (sum, item) => sum + item.subtotal);

  int get itemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  OrderEntity copyWith({
    String? id,
    String? tableId,
    String? tableName,
    DateTime? createdAt,
    OrderStatus? status,
    List<OrderItemEntity>? items,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      tableName: tableName ?? this.tableName,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }
}
