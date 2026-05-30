import '../enums/payment_status.dart';
import '../enums/payment_method.dart';

class PaymentEntity {
  final String id;
  final String orderId;
  final String tableId;
  final double amount;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final DateTime paidAt;

  const PaymentEntity({
    required this.id,
    required this.orderId,
    required this.tableId,
    required this.amount,
    required this.paymentMethod,
    this.paymentStatus = PaymentStatus.paid,
    required this.paidAt,
  });

  PaymentEntity copyWith({
    String? id,
    String? orderId,
    String? tableId,
    double? amount,
    PaymentMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    DateTime? paidAt,
  }) {
    return PaymentEntity(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      tableId: tableId ?? this.tableId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paidAt: paidAt ?? this.paidAt,
    );
  }
}
