import 'realtime_event.dart';

class PaymentCompletedEvent extends RealtimeEvent {
  final String orderId;
  final String tableId;
  final String tableName;
  final String paymentMethod;
  final double amount;

  PaymentCompletedEvent({
    required this.orderId,
    required this.tableId,
    required this.tableName,
    required this.paymentMethod,
    required this.amount,
  });
}
