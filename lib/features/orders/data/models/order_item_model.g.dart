// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemModelImpl _$$OrderItemModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemModelImpl(
      menuItem: MenuItemModel.fromJson(
        json['menuItem'] as Map<String, dynamic>,
      ),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$$OrderItemModelImplToJson(
  _$OrderItemModelImpl instance,
) => <String, dynamic>{
  'menuItem': instance.menuItem,
  'quantity': instance.quantity,
  'note': instance.note,
};
