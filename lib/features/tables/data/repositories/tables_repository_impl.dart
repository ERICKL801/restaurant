import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/enums/table_status.dart';
import '../../domain/repositories/tables_repository.dart';
import '../datasources/tables_local_datasource.dart';

final tablesRepositoryProvider = Provider<TablesRepository>((ref) {
  return TablesRepositoryImpl(
    ref.watch(tablesLocalDataSourceProvider),
  );
});

class TablesRepositoryImpl implements TablesRepository {
  final TablesLocalDataSource _dataSource;

  TablesRepositoryImpl(this._dataSource);

  @override
  Future<List<TableEntity>> getTables() async {
    final models = await _dataSource.getTables();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<TableEntity> updateStatus({
    required String tableId,
    required TableStatus status,
  }) async {
    final model = await _dataSource.updateStatus(
      tableId: tableId,
      status: status.value,
    );
    return model.toEntity();
  }
}
