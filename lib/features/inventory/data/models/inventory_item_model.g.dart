// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryItemModelImpl _$$InventoryItemModelImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryItemModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  unit: json['unit'] as String,
  currentStock: (json['currentStock'] as num?)?.toDouble() ?? 0.0,
  minimumStock: (json['minimumStock'] as num?)?.toDouble() ?? 0.0,
  costPrice: (json['costPrice'] as num?)?.toDouble() ?? 0.0,
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$$InventoryItemModelImplToJson(
  _$InventoryItemModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'unit': instance.unit,
  'currentStock': instance.currentStock,
  'minimumStock': instance.minimumStock,
  'costPrice': instance.costPrice,
  'active': instance.active,
};
