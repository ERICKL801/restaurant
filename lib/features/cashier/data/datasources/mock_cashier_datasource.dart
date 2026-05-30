import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../orders/data/datasources/orders_local_datasource.dart';
import '../../../orders/data/models/order_model.dart';
import '../../../tables/data/datasources/tables_local_datasource.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/entities/pending_payment_entity.dart';
import '../../domain/entities/receipt_entity.dart';
import '../../domain/enums/payment_method.dart';
import '../../domain/enums/payment_status.dart';
import '../models/payment_model.dart';
import '../models/receipt_model.dart';
import 'cashier_datasource.dart';

final mockCashierDataSourceProvider = Provider<CashierDataSource>((ref) {
  return MockCashierDataSource(
    ordersDataSource: ref.watch(ordersLocalDataSourceProvider),
    tablesDataSource: ref.watch(tablesLocalDataSourceProvider),
  );
});

class MockCashierDataSource implements CashierDataSource {
  final OrdersLocalDataSource _ordersDataSource;
  final TablesLocalDataSource _tablesDataSource;
  final List<PaymentModel> _payments = [];
  final List<ReceiptModel> _receipts = [];
  int _receiptCounter = 0;

  static const double _taxRate = 0.18;
  static const List<String> _pendingStatuses = ['delivered'];

  MockCashierDataSource({
    required OrdersLocalDataSource ordersDataSource,
    required TablesLocalDataSource tablesDataSource,
  })  : _ordersDataSource = ordersDataSource,
        _tablesDataSource = tablesDataSource;

  @override
  Future<List<PendingPaymentEntity>> getPendingPayments() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final orders = await _ordersDataSource.getOrdersByStatuses(_pendingStatuses);
    return orders.map((o) => _mapToPendingPayment(o)).toList();
  }

  @override
  Future<PaymentEntity> processPayment({
    required String orderId,
    required String tableId,
    required double amount,
    required PaymentMethod method,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final payment = PaymentModel(
      id: 'PAY-${_payments.length + 1}',
      orderId: orderId,
      tableId: tableId,
      amount: amount,
      paymentMethod: method,
      paymentStatus: PaymentStatus.paid,
      paidAt: DateTime.now(),
    );
    _payments.add(payment);

    await _ordersDataSource.updateOrderStatus(
      orderId: orderId,
      status: 'completed',
    );

    await _tablesDataSource.updateStatus(
      tableId: tableId,
      status: 'available',
    );

    return payment.toEntity();
  }

  @override
  Future<ReceiptEntity> generateReceipt({
    required PaymentEntity payment,
    required double subtotal,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _receiptCounter++;
    final tax = subtotal * _taxRate;
    final total = subtotal + tax;

    final receipt = ReceiptModel(
      receiptNumber: 'REC-${_receiptCounter.toString().padLeft(4, '0')}',
      orderId: payment.orderId,
      paymentId: payment.id,
      issuedAt: DateTime.now(),
      subtotal: subtotal,
      tax: tax,
      total: total,
    );
    _receipts.add(receipt);
    return receipt.toEntity();
  }

  PendingPaymentEntity _mapToPendingPayment(OrderModel order) {
    final total = order.items.fold(
      0.0,
      (sum, i) => sum + (i.menuItem.price * i.quantity),
    );
    final itemCount = order.items.fold(0, (sum, i) => sum + i.quantity);
    return PendingPaymentEntity(
      orderId: order.id,
      tableId: order.tableId,
      tableName: order.tableName,
      total: total,
      createdAt: order.createdAt,
      itemCount: itemCount,
    );
  }
}
