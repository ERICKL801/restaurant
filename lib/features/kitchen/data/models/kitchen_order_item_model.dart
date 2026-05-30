import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/kitchen_order_item_entity.dart';

part 'kitchen_order_item_model.freezed.dart';
part 'kitchen_order_item_model.g.dart';

@freezed
class KitchenOrderItemModel with _$KitchenOrderItemModel {
  const factory KitchenOrderItemModel({
    required String name,
    @Default(1) int quantity,
    @Default('') String note,
  }) = _KitchenOrderItemModel;

  const KitchenOrderItemModel._();

  factory KitchenOrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$KitchenOrderItemModelFromJson(json);

  KitchenOrderItemEntity toEntity() => KitchenOrderItemEntity(
        name: name,
        quantity: quantity,
        note: note,
      );
}
