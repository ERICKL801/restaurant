// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KitchenOrderItemModelImpl _$$KitchenOrderItemModelImplFromJson(
  Map<String, dynamic> json,
) => _$KitchenOrderItemModelImpl(
  name: json['name'] as String,
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  note: json['note'] as String? ?? '',
);

Map<String, dynamic> _$$KitchenOrderItemModelImplToJson(
  _$KitchenOrderItemModelImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'quantity': instance.quantity,
  'note': instance.note,
};
