import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/receipt_entity.dart';

part 'receipt_model.freezed.dart';
part 'receipt_model.g.dart';

@freezed
class ReceiptModel with _$ReceiptModel {
  const factory ReceiptModel({
    required String receiptNumber,
    required String orderId,
    required String paymentId,
    required DateTime issuedAt,
    required double subtotal,
    required double tax,
    required double total,
  }) = _ReceiptModel;

  const ReceiptModel._();

  factory ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptModelFromJson(json);

  ReceiptEntity toEntity() => ReceiptEntity(
        receiptNumber: receiptNumber,
        orderId: orderId,
        paymentId: paymentId,
        issuedAt: issuedAt,
        subtotal: subtotal,
        tax: tax,
        total: total,
      );
}
