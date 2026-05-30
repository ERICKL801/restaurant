// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockMovementModelImpl _$$StockMovementModelImplFromJson(
  Map<String, dynamic> json,
) => _$StockMovementModelImpl(
  id: json['id'] as String,
  inventoryItemId: json['inventoryItemId'] as String,
  movementType: $enumDecode(_$MovementTypeEnumMap, json['movementType']),
  quantity: (json['quantity'] as num).toDouble(),
  previousStock: (json['previousStock'] as num?)?.toDouble() ?? 0.0,
  currentStock: (json['currentStock'] as num?)?.toDouble() ?? 0.0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  note: json['note'] as String? ?? '',
);

Map<String, dynamic> _$$StockMovementModelImplToJson(
  _$StockMovementModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'inventoryItemId': instance.inventoryItemId,
  'movementType': _$MovementTypeEnumMap[instance.movementType]!,
  'quantity': instance.quantity,
  'previousStock': instance.previousStock,
  'currentStock': instance.currentStock,
  'createdAt': instance.createdAt.toIso8601String(),
  'note': instance.note,
};

const _$MovementTypeEnumMap = {
  MovementType.entry: 'entry',
  MovementType.exit: 'exit',
  MovementType.adjustment: 'adjustment',
};
