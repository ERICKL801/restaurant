import '../../domain/entities/payment_entity.dart';
import '../../domain/entities/pending_payment_entity.dart';
import '../../domain/entities/receipt_entity.dart';
import '../../domain/enums/payment_method.dart';

abstract class CashierDataSource {
  Future<List<PendingPaymentEntity>> getPendingPayments();
  Future<PaymentEntity> processPayment({
    required String orderId,
    required String tableId,
    required double amount,
    required PaymentMethod method,
  });
  Future<ReceiptEntity> generateReceipt({
    required PaymentEntity payment,
    required double subtotal,
  });
}
