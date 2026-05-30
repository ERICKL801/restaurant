// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReceiptModelImpl _$$ReceiptModelImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptModelImpl(
      receiptNumber: json['receiptNumber'] as String,
      orderId: json['orderId'] as String,
      paymentId: json['paymentId'] as String,
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$ReceiptModelImplToJson(_$ReceiptModelImpl instance) =>
    <String, dynamic>{
      'receiptNumber': instance.receiptNumber,
      'orderId': instance.orderId,
      'paymentId': instance.paymentId,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'total': instance.total,
    };
