import '../entities/table_entity.dart';
import '../enums/table_status.dart';

abstract class TablesRepository {
  Future<List<TableEntity>> getTables();
  Future<TableEntity> updateStatus({
    required String tableId,
    required TableStatus status,
  });
}
