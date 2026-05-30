import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../events/order_events.dart';
import '../events/payment_events.dart';
import '../events/inventory_events.dart';
import '../services/local_realtime_service.dart';
import '../services/realtime_service.dart';

final realtimeServiceProvider = Provider<RealtimeService>((ref) {
  final service = LocalRealtimeService();
  ref.onDispose(() => service.dispose());
  return service;
});

final orderSentEventProvider = StreamProvider<OrderSentEvent>((ref) {
  return ref.watch(realtimeServiceProvider).events<OrderSentEvent>();
});

final orderPreparingEventProvider = StreamProvider<OrderPreparingEvent>((ref) {
  return ref.watch(realtimeServiceProvider).events<OrderPreparingEvent>();
});

final orderReadyEventProvider = StreamProvider<OrderReadyEvent>((ref) {
  return ref.watch(realtimeServiceProvider).events<OrderReadyEvent>();
});

final orderDeliveredEventProvider = StreamProvider<OrderDeliveredEvent>((ref) {
  return ref.watch(realtimeServiceProvider).events<OrderDeliveredEvent>();
});

final paymentCompletedEventProvider =
    StreamProvider<PaymentCompletedEvent>((ref) {
  return ref.watch(realtimeServiceProvider).events<PaymentCompletedEvent>();
});

final inventoryUpdatedEventProvider =
    StreamProvider<InventoryUpdatedEvent>((ref) {
  return ref.watch(realtimeServiceProvider).events<InventoryUpdatedEvent>();
});
