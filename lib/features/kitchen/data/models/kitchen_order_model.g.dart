// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KitchenOrderModelImpl _$$KitchenOrderModelImplFromJson(
  Map<String, dynamic> json,
) => _$KitchenOrderModelImpl(
  id: json['id'] as String,
  tableId: json['tableId'] as String,
  tableName: json['tableName'] as String,
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => KitchenOrderItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  status: $enumDecode(_$KitchenOrderStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  notes: json['notes'] as String?,
  total: (json['total'] as num).toDouble(),
);

Map<String, dynamic> _$$KitchenOrderModelImplToJson(
  _$KitchenOrderModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'tableId': instance.tableId,
  'tableName': instance.tableName,
  'items': instance.items,
  'status': _$KitchenOrderStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'notes': instance.notes,
  'total': instance.total,
};

const _$KitchenOrderStatusEnumMap = {
  KitchenOrderStatus.sent: 'sent',
  KitchenOrderStatus.preparing: 'preparing',
  KitchenOrderStatus.ready: 'ready',
  KitchenOrderStatus.delivered: 'delivered',
};
