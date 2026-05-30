import '../entities/payment_entity.dart';
import '../entities/pending_payment_entity.dart';
import '../entities/receipt_entity.dart';
import '../enums/payment_method.dart';

abstract class CashierRepository {
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
