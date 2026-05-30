import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/table_entity.dart';
import '../enums/table_status.dart';
import '../repositories/tables_repository.dart';
import '../../data/repositories/tables_repository_impl.dart';

final updateTableStatusUseCaseProvider = Provider<UpdateTableStatusUseCase>((ref) {
  return UpdateTableStatusUseCase(ref.watch(tablesRepositoryProvider));
});

class UpdateTableStatusUseCase {
  final TablesRepository _repository;

  UpdateTableStatusUseCase(this._repository);

  Future<TableEntity> call({
    required String tableId,
    required TableStatus status,
  }) {
    return _repository.updateStatus(tableId: tableId, status: status);
  }
}
