import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_item_entity.dart';
import 'menu_item_model.dart';

part 'order_item_model.freezed.dart';
part 'order_item_model.g.dart';

@freezed
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required MenuItemModel menuItem,
    @Default(1) int quantity,
    @Default('') String note,
  }) = _OrderItemModel;

  const OrderItemModel._();

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  factory OrderItemModel.fromEntity(OrderItemEntity entity) =>
      OrderItemModel(
        menuItem: MenuItemModel.fromEntity(entity.menuItem),
        quantity: entity.quantity,
        note: entity.note,
      );

  OrderItemEntity toEntity() => OrderItemEntity(
        menuItem: menuItem.toEntity(),
        quantity: quantity,
        note: note,
      );
}
