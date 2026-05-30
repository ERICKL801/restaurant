import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/table_entity.dart';
import '../repositories/tables_repository.dart';
import '../../data/repositories/tables_repository_impl.dart';

final getTablesUseCaseProvider = Provider<GetTablesUseCase>((ref) {
  return GetTablesUseCase(ref.watch(tablesRepositoryProvider));
});

class GetTablesUseCase {
  final TablesRepository _repository;

  GetTablesUseCase(this._repository);

  Future<List<TableEntity>> call() {
    return _repository.getTables();
  }
}
