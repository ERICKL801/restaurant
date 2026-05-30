import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/usecases/create_order_usecase.dart';

const _orderIdPrefix = 'ORD-';

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier(ref.watch(createOrderUseCaseProvider));
});

class OrderState {
  final String tableId;
  final String tableName;
  final List<OrderItemEntity> items;
  final bool isSending;
  final bool isSent;
  final String? error;
  final String? lastOrderId;

  const OrderState({
    this.tableId = '',
    this.tableName = '',
    this.items = const [],
    this.isSending = false,
    this.isSent = false,
    this.error,
    this.lastOrderId,
  });

  double get total =>
      items.fold(0.0, (sum, item) => sum + item.subtotal);

  int get itemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  bool get hasItems => items.isNotEmpty;

  OrderState copyWith({
    String? tableId,
    String? tableName,
    List<OrderItemEntity>? items,
    bool? isSending,
    bool? isSent,
    String? error,
    String? lastOrderId,
  }) {
    return OrderState(
      tableId: tableId ?? this.tableId,
      tableName: tableName ?? this.tableName,
      items: items ?? this.items,
      isSending: isSending ?? this.isSending,
      isSent: isSent ?? this.isSent,
      error: error,
      lastOrderId: lastOrderId,
    );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  final CreateOrderUseCase _createOrder;
  int _orderCounter = 0;

  OrderNotifier(this._createOrder) : super(const OrderState());

  void initialize({
    required String tableId,
    required String tableName,
  }) {
    state = state.copyWith(
      tableId: tableId,
      tableName: tableName,
      items: [],
      isSending: false,
      isSent: false,
      error: null,
      lastOrderId: null,
    );
  }

  void addItem(MenuItemEntity item) {
    final existingIndex = state.items.indexWhere(
      (i) => i.menuItem.id == item.id,
    );

    if (existingIndex >= 0) {
      final existing = state.items[existingIndex];
      final updated = existing.copyWith(quantity: existing.quantity + 1);
      final newItems = [...state.items];
      newItems[existingIndex] = updated;
      state = state.copyWith(items: newItems, error: null);
    } else {
      final newItem = OrderItemEntity(menuItem: item, quantity: 1);
      state = state.copyWith(
        items: [...state.items, newItem],
        error: null,
      );
    }
  }

  void removeItem(String menuItemId) {
    state = state.copyWith(
      items: state.items.where((i) => i.menuItem.id != menuItemId).toList(),
    );
  }

  void updateQuantity({
    required String menuItemId,
    required int quantity,
  }) {
    if (quantity <= 0) {
      removeItem(menuItemId);
      return;
    }

    final newItems = state.items.map((i) {
      if (i.menuItem.id == menuItemId) {
        return i.copyWith(quantity: quantity);
      }
      return i;
    }).toList();

    state = state.copyWith(items: newItems);
  }

  void updateNote({
    required String menuItemId,
    required String note,
  }) {
    final newItems = state.items.map((i) {
      if (i.menuItem.id == menuItemId) {
        return i.copyWith(note: note);
      }
      return i;
    }).toList();

    state = state.copyWith(items: newItems);
  }

  Future<void> sendOrder() async {
    if (!state.hasItems) return;

    state = state.copyWith(isSending: true, error: null);
    _orderCounter++;

    final order = OrderEntity(
      id: '$_orderIdPrefix${_orderCounter.toString().padLeft(4, '0')}',
      tableId: state.tableId,
      tableName: state.tableName,
      createdAt: DateTime.now(),
      status: OrderStatus.sent,
      items: state.items,
    );

    try {
      final created = await _createOrder(order);
      state = state.copyWith(
        isSending: false,
        isSent: true,
        items: [],
        lastOrderId: created.id,
      );
    } catch (e) {
      state = state.copyWith(
        isSending: false,
        error: e.toString(),
      );
    }
  }
}
