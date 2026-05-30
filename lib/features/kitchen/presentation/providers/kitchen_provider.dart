import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/realtime/events/order_events.dart';
import '../../../../core/realtime/providers/realtime_providers.dart';
import '../../../../core/realtime/services/realtime_service.dart';
import '../../data/repositories/kitchen_repository_impl.dart';
import '../../domain/entities/kitchen_order_entity.dart';
import '../../domain/enums/kitchen_order_status.dart';
import '../../domain/repositories/kitchen_repository.dart';

final kitchenProvider =
    StateNotifierProvider<KitchenNotifier, KitchenState>((ref) {
  final repository = ref.watch(kitchenRepositoryProvider);
  final realtimeService = ref.watch(realtimeServiceProvider);
  final notifier = KitchenNotifier(repository, realtimeService);

  ref.listen(orderSentEventProvider, (prev, next) {
    final event = next.valueOrNull;
    if (event != null) {
      notifier.loadOrders();
    }
  });

  return notifier;
});

class KitchenState {
  final List<KitchenOrderEntity> orders;
  final bool isLoading;
  final String? error;
  final DateTime? lastUpdated;

  const KitchenState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
    this.lastUpdated,
  });

  List<KitchenOrderEntity> ordersByStatus(KitchenOrderStatus status) =>
      orders.where((o) => o.status == status).toList();

  int get totalOrders => orders.length;

  KitchenState copyWith({
    List<KitchenOrderEntity>? orders,
    bool? isLoading,
    String? error,
    DateTime? lastUpdated,
  }) {
    return KitchenState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class KitchenNotifier extends StateNotifier<KitchenState> {
  final KitchenRepository _repository;
  final RealtimeService _realtimeService;
  Timer? _pollTimer;

  KitchenNotifier(this._repository, this._realtimeService)
      : super(const KitchenState());

  void startPolling() {
    _pollTimer?.cancel();
    loadOrders();
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      loadOrders();
    });
  }

  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final orders = await _repository.getOrders();
      state = state.copyWith(
        orders: orders,
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> advanceOrder(String orderId) async {
    final order = state.orders.firstWhere((o) => o.id == orderId);
    final nextStatus = order.status.nextStatus;
    if (nextStatus == null) return;

    try {
      await _repository.updateOrderStatus(orderId, nextStatus);
      if (nextStatus == KitchenOrderStatus.preparing) {
        _realtimeService.emit(OrderPreparingEvent(
          orderId: orderId,
          tableName: order.tableName,
        ));
      } else if (nextStatus == KitchenOrderStatus.ready) {
        _realtimeService.emit(OrderReadyEvent(
          orderId: orderId,
          tableName: order.tableName,
        ));
      } else if (nextStatus == KitchenOrderStatus.delivered) {
        _realtimeService.emit(OrderDeliveredEvent(
          orderId: orderId,
          tableId: order.tableId,
          tableName: order.tableName,
        ));
      }
      await loadOrders();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}
