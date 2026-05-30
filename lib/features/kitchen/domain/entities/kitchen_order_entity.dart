import '../enums/kitchen_order_status.dart';
import 'kitchen_order_item_entity.dart';

class KitchenOrderEntity {
  final String id;
  final String tableName;
  final List<KitchenOrderItemEntity> items;
  final KitchenOrderStatus status;
  final DateTime createdAt;
  final String? notes;
  final double total;

  const KitchenOrderEntity({
    required this.id,
    required this.tableName,
    required this.items,
    required this.status,
    required this.createdAt,
    this.notes,
    required this.total,
  });

  KitchenOrderEntity copyWith({
    String? id,
    String? tableName,
    List<KitchenOrderItemEntity>? items,
    KitchenOrderStatus? status,
    DateTime? createdAt,
    String? notes,
    double? total,
  }) {
    return KitchenOrderEntity(
      id: id ?? this.id,
      tableName: tableName ?? this.tableName,
      items: items ?? this.items,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
      total: total ?? this.total,
    );
  }
}
