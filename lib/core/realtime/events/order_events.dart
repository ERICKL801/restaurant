import 'realtime_event.dart';

class OrderSentEvent extends RealtimeEvent {
  final String orderId;
  final String tableId;
  final String tableName;
  final int itemCount;

  OrderSentEvent({
    required this.orderId,
    required this.tableId,
    required this.tableName,
    required this.itemCount,
  });
}

class OrderPreparingEvent extends RealtimeEvent {
  final String orderId;
  final String tableName;

  OrderPreparingEvent({
    required this.orderId,
    required this.tableName,
  });
}

class OrderReadyEvent extends RealtimeEvent {
  final String orderId;
  final String tableName;

  OrderReadyEvent({
    required this.orderId,
    required this.tableName,
  });
}

class OrderDeliveredEvent extends RealtimeEvent {
  final String orderId;
  final String tableId;
  final String tableName;

  OrderDeliveredEvent({
    required this.orderId,
    required this.tableId,
    required this.tableName,
  });
}
