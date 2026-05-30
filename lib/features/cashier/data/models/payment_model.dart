import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/enums/payment_method.dart';
import '../../domain/enums/payment_status.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    required String id,
    required String orderId,
    required String tableId,
    required double amount,
    required PaymentMethod paymentMethod,
    @Default(PaymentStatus.paid) PaymentStatus paymentStatus,
    required DateTime paidAt,
  }) = _PaymentModel;

  const PaymentModel._();

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  PaymentEntity toEntity() => PaymentEntity(
        id: id,
        orderId: orderId,
        tableId: tableId,
        amount: amount,
        paymentMethod: paymentMethod,
        paymentStatus: paymentStatus,
        paidAt: paidAt,
      );
}
