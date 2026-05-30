import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/enums/table_status.dart';
import '../../domain/usecases/get_tables_usecase.dart';
import '../../domain/usecases/update_table_status_usecase.dart';

final tablesProvider = StateNotifierProvider<TablesNotifier, TablesState>((ref) {
  return TablesNotifier(
    ref.watch(getTablesUseCaseProvider),
    ref.watch(updateTableStatusUseCaseProvider),
  );
});

class TablesState {
  final List<TableEntity> tables;
  final bool isLoading;
  final String? error;
  final TableStatus? filter;

  const TablesState({
    this.tables = const [],
    this.isLoading = false,
    this.error,
    this.filter,
  });

  List<TableEntity> get filteredTables {
    if (filter == null) return tables;
    return tables.where((t) => t.status == filter).toList();
  }

  int get count => filteredTables.length;
  int get totalCount => tables.length;

  TablesState copyWith({
    List<TableEntity>? tables,
    bool? isLoading,
    String? error,
    TableStatus? filter,
  }) {
    return TablesState(
      tables: tables ?? this.tables,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filter: filter ?? this.filter,
    );
  }
}

class TablesNotifier extends StateNotifier<TablesState> {
  final GetTablesUseCase _getTables;
  final UpdateTableStatusUseCase _updateStatus;

  TablesNotifier(this._getTables, this._updateStatus)
      : super(const TablesState());

  Future<void> loadTables() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final tables = await _getTables();
      state = state.copyWith(tables: tables, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateStatus({
    required String tableId,
    required TableStatus status,
  }) async {
    try {
      await _updateStatus(tableId: tableId, status: status);
      await loadTables();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void setFilter(TableStatus? filter) {
    state = state.copyWith(filter: filter);
  }
}
