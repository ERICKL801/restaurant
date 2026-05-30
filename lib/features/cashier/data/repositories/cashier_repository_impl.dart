import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/entities/pending_payment_entity.dart';
import '../../domain/entities/receipt_entity.dart';
import '../../domain/enums/payment_method.dart';
import '../../domain/repositories/cashier_repository.dart';
import '../datasources/cashier_datasource.dart';
import '../datasources/mock_cashier_datasource.dart';

final cashierRepositoryProvider = Provider<CashierRepository>((ref) {
  return CashierRepositoryImpl(ref.watch(mockCashierDataSourceProvider));
});

class CashierRepositoryImpl implements CashierRepository {
  final CashierDataSource _dataSource;

  CashierRepositoryImpl(this._dataSource);

  @override
  Future<List<PendingPaymentEntity>> getPendingPayments() =>
      _dataSource.getPendingPayments();

  @override
  Future<PaymentEntity> processPayment({
    required String orderId,
    required String tableId,
    required double amount,
    required PaymentMethod method,
  }) => _dataSource.processPayment(
    orderId: orderId,
    tableId: tableId,
    amount: amount,
    method: method,
  );

  @override
  Future<ReceiptEntity> generateReceipt({
    required PaymentEntity payment,
    required double subtotal,
  }) => _dataSource.generateReceipt(payment: payment, subtotal: subtotal);
}
