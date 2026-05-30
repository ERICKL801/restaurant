import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/kitchen_order_entity.dart';
import '../../domain/enums/kitchen_order_status.dart';
import 'kitchen_order_item_model.dart';

part 'kitchen_order_model.freezed.dart';
part 'kitchen_order_model.g.dart';

@freezed
class KitchenOrderModel with _$KitchenOrderModel {
  const factory KitchenOrderModel({
    required String id,
    required String tableId,
    required String tableName,
    @Default([]) List<KitchenOrderItemModel> items,
    required KitchenOrderStatus status,
    required DateTime createdAt,
    String? notes,
    required double total,
  }) = _KitchenOrderModel;

  const KitchenOrderModel._();

  factory KitchenOrderModel.fromJson(Map<String, dynamic> json) =>
      _$KitchenOrderModelFromJson(json);

  KitchenOrderEntity toEntity() => KitchenOrderEntity(
        id: id,
        tableId: tableId,
        tableName: tableName,
        items: items.map((i) => i.toEntity()).toList(),
        status: status,
        createdAt: createdAt,
        notes: notes,
        total: total,
      );
}
