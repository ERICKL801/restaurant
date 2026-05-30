import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/realtime/events/payment_events.dart';
import '../../../../core/realtime/services/realtime_service.dart';
import '../../../../core/realtime/providers/realtime_providers.dart';
import '../../../orders/domain/entities/order_item_entity.dart';
import '../../../orders/domain/repositories/order_repository.dart';
import '../../../orders/data/repositories/order_repository_impl.dart';
import '../../data/repositories/cashier_repository_impl.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/entities/receipt_entity.dart';
import '../../domain/enums/payment_method.dart';
import '../../domain/repositories/cashier_repository.dart';

const double _taxRate = 0.18;

final paymentDetailProvider =
    StateNotifierProvider<PaymentDetailNotifier, PaymentDetailState>((ref) {
  return PaymentDetailNotifier(
    cashierRepository: ref.watch(cashierRepositoryProvider),
    orderRepository: ref.watch(orderRepositoryProvider),
    realtimeService: ref.watch(realtimeServiceProvider),
  );
});

class PaymentDetailState {
  final String orderId;
  final String tableId;
  final String tableName;
  final List<OrderItemEntity> items;
  final double subtotal;
  final double tax;
  final double total;
  final PaymentMethod? selectedMethod;
  final bool isProcessing;
  final bool isCompleted;
  final ReceiptEntity? receipt;
  final PaymentEntity? payment;
  final String? error;
  final bool isLoading;

  const PaymentDetailState({
    this.orderId = '',
    this.tableId = '',
    this.tableName = '',
    this.items = const [],
    this.subtotal = 0,
    this.tax = 0,
    this.total = 0,
    this.selectedMethod,
    this.isProcessing = false,
    this.isCompleted = false,
    this.receipt,
    this.payment,
    this.error,
    this.isLoading = false,
  });

  PaymentDetailState copyWith({
    String? orderId,
    String? tableId,
    String? tableName,
    List<OrderItemEntity>? items,
    double? subtotal,
    double? tax,
    double? total,
    PaymentMethod? selectedMethod,
    bool? isProcessing,
    bool? isCompleted,
    ReceiptEntity? receipt,
    PaymentEntity? payment,
    String? error,
    bool? isLoading,
  }) {
    return PaymentDetailState(
      orderId: orderId ?? this.orderId,
      tableId: tableId ?? this.tableId,
      tableName: tableName ?? this.tableName,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      selectedMethod: selectedMethod,
      isProcessing: isProcessing ?? this.isProcessing,
      isCompleted: isCompleted ?? this.isCompleted,
      receipt: receipt,
      payment: payment,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PaymentDetailNotifier extends StateNotifier<PaymentDetailState> {
  final CashierRepository _cashierRepository;
  final OrderRepository _orderRepository;
  final RealtimeService _realtimeService;

  PaymentDetailNotifier({
    required CashierRepository cashierRepository,
    required OrderRepository orderRepository,
    required RealtimeService realtimeService,
  })  : _cashierRepository = cashierRepository,
        _orderRepository = orderRepository,
        _realtimeService = realtimeService,
        super(const PaymentDetailState());

  Future<void> initialize({
    required String orderId,
    required String tableId,
    required String tableName,
  }) async {
    state = state.copyWith(
      orderId: orderId,
      tableId: tableId,
      tableName: tableName,
      isLoading: true,
      error: null,
    );

    try {
      final order = await _orderRepository.getOrderById(orderId);
      if (order == null) {
        state = state.copyWith(isLoading: false, error: 'Pedido no encontrado');
        return;
      }

      final subtotal = order.total;
      final tax = subtotal * _taxRate;
      final total = subtotal + tax;

      state = state.copyWith(
        items: order.items,
        subtotal: subtotal,
        tax: tax,
        total: total,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void selectMethod(PaymentMethod method) {
    state = state.copyWith(selectedMethod: method, error: null);
  }

  Future<void> processPayment() async {
    if (state.selectedMethod == null) {
      state = state.copyWith(error: 'Seleccione un método de pago');
      return;
    }

    state = state.copyWith(isProcessing: true, error: null);

    try {
      final payment = await _cashierRepository.processPayment(
        orderId: state.orderId,
        tableId: state.tableId,
        amount: state.total,
        method: state.selectedMethod!,
      );

      final receipt = await _cashierRepository.generateReceipt(
        payment: payment,
        subtotal: state.subtotal,
      );

      _realtimeService.emit(PaymentCompletedEvent(
        orderId: state.orderId,
        tableId: state.tableId,
        tableName: state.tableName,
        paymentMethod: state.selectedMethod!.displayName,
        amount: state.total,
      ));

      state = state.copyWith(
        isProcessing: false,
        isCompleted: true,
        payment: payment,
        receipt: receipt,
      );
    } catch (e) {
      state = state.copyWith(isProcessing: false, error: e.toString());
    }
  }

  void reset() {
    state = const PaymentDetailState();
  }
}
