import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/enums/order_status.dart';
import 'order_item_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    required String tableId,
    required String tableName,
    required DateTime createdAt,
    @Default('draft') String status,
    @Default([]) List<OrderItemModel> items,
  }) = _OrderModel;

  const OrderModel._();

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  factory OrderModel.fromEntity(OrderEntity entity) => OrderModel(
        id: entity.id,
        tableId: entity.tableId,
        tableName: entity.tableName,
        createdAt: entity.createdAt,
        status: entity.status.value,
        items: entity.items.map((i) => OrderItemModel.fromEntity(i)).toList(),
      );

  OrderEntity toEntity() => OrderEntity(
        id: id,
        tableId: tableId,
        tableName: tableName,
        createdAt: createdAt,
        status: OrderStatus.fromString(status),
        items: items.map((i) => i.toEntity()).toList(),
      );
}
