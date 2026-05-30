// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: json['id'] as String,
      tableId: json['tableId'] as String,
      tableName: json['tableName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String? ?? 'draft',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableId': instance.tableId,
      'tableName': instance.tableName,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
      'items': instance.items,
    };
