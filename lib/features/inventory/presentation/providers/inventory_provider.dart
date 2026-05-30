import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/realtime/providers/realtime_providers.dart';
import '../../data/repositories/inventory_repository_impl.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/enums/stock_status.dart';
import '../../domain/repositories/inventory_repository.dart';

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, InventoryState>((ref) {
  final notifier = InventoryNotifier(ref.watch(inventoryRepositoryProvider));

  ref.listen(inventoryUpdatedEventProvider, (prev, next) {
    final event = next.valueOrNull;
    if (event != null) {
      notifier.loadItems();
    }
  });

  return notifier;
});

class InventoryState {
  final List<InventoryItemEntity> items;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final String? categoryFilter;
  final StockStatus? statusFilter;

  const InventoryState({
    this.items = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.categoryFilter,
    this.statusFilter,
  });

  List<String> get categories {
    final cats = items.map((i) => i.category).toSet().toList()..sort();
    return cats;
  }

  List<InventoryItemEntity> get filteredItems {
    var result = items.toList();
    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      result = result.where((i) => i.name.toLowerCase().contains(q)).toList();
    }
    if (categoryFilter != null) {
      result = result.where((i) => i.category == categoryFilter).toList();
    }
    if (statusFilter != null) {
      result = result.where((i) => i.stockStatus == statusFilter).toList();
    }
    return result;
  }

  InventoryState copyWith({
    List<InventoryItemEntity>? items,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? categoryFilter,
    StockStatus? statusFilter,
    bool clearCategoryFilter = false,
    bool clearStatusFilter = false,
  }) {
    return InventoryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      categoryFilter: clearCategoryFilter ? null : (categoryFilter ?? this.categoryFilter),
      statusFilter: clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
    );
  }
}

class InventoryNotifier extends StateNotifier<InventoryState> {
  final InventoryRepository _repository;

  InventoryNotifier(this._repository) : super(const InventoryState());

  Future<void> loadItems() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items = await _repository.getItems();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setCategoryFilter(String? category) {
    state = state.copyWith(
      categoryFilter: category,
      clearCategoryFilter: category == null,
    );
  }

  void setStatusFilter(StockStatus? status) {
    state = state.copyWith(
      statusFilter: status,
      clearStatusFilter: status == null,
    );
  }
}
