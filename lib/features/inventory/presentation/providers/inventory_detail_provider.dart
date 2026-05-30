import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/realtime/events/inventory_events.dart';
import '../../../../core/realtime/services/realtime_service.dart';
import '../../../../core/realtime/providers/realtime_providers.dart';
import '../../data/repositories/inventory_repository_impl.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/entities/stock_movement_entity.dart';
import '../../domain/enums/movement_type.dart';
import '../../domain/repositories/inventory_repository.dart';

final inventoryDetailProvider =
    StateNotifierProvider<InventoryDetailNotifier, InventoryDetailState>(
        (ref) {
  return InventoryDetailNotifier(
    ref.watch(inventoryRepositoryProvider),
    ref.watch(realtimeServiceProvider),
  );
});

class InventoryDetailState {
  final InventoryItemEntity? item;
  final List<StockMovementEntity> movements;
  final bool isLoading;
  final bool isProcessing;
  final String? error;

  const InventoryDetailState({
    this.item,
    this.movements = const [],
    this.isLoading = false,
    this.isProcessing = false,
    this.error,
  });

  InventoryDetailState copyWith({
    InventoryItemEntity? item,
    List<StockMovementEntity>? movements,
    bool? isLoading,
    bool? isProcessing,
    String? error,
  }) {
    return InventoryDetailState(
      item: item ?? this.item,
      movements: movements ?? this.movements,
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error,
    );
  }
}

class InventoryDetailNotifier extends StateNotifier<InventoryDetailState> {
  final InventoryRepository _repository;
  final RealtimeService _realtimeService;

  InventoryDetailNotifier(this._repository, this._realtimeService)
      : super(const InventoryDetailState());

  Future<void> loadItem(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final item = await _repository.getItemById(id);
      final movements = await _repository.getMovements(id);
      state = state.copyWith(
        item: item,
        movements: movements,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> registerMovement({
    required String itemId,
    required MovementType type,
    required double quantity,
    required String note,
  }) async {
    state = state.copyWith(isProcessing: true, error: null);
    try {
      final updated = await _repository.registerMovement(
        itemId: itemId,
        type: type,
        quantity: quantity,
        note: note,
      );
      _realtimeService.emit(InventoryUpdatedEvent(
        itemId: itemId,
        itemName: updated.name,
        newStock: updated.currentStock,
        movementType: type.displayName,
      ));
      final movements = await _repository.getMovements(itemId);
      state = state.copyWith(
        item: updated,
        movements: movements,
        isProcessing: false,
      );
    } catch (e) {
      state = state.copyWith(isProcessing: false, error: e.toString());
    }
  }
}
