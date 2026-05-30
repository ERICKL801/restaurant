import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/entities/stock_movement_entity.dart';
import '../../domain/enums/movement_type.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../datasources/inventory_datasource.dart';
import '../datasources/mock_inventory_datasource.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepositoryImpl(ref.watch(mockInventoryDatasourceProvider));
});

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryDatasource _dataSource;

  InventoryRepositoryImpl(this._dataSource);

  @override
  Future<List<InventoryItemEntity>> getItems() => _dataSource.getItems();

  @override
  Future<InventoryItemEntity?> getItemById(String id) =>
      _dataSource.getItemById(id);

  @override
  Future<List<StockMovementEntity>> getMovements(String itemId) =>
      _dataSource.getMovements(itemId);

  @override
  Future<InventoryItemEntity> registerMovement({
    required String itemId,
    required MovementType type,
    required double quantity,
    required String note,
  }) => _dataSource.registerMovement(
    itemId: itemId,
    type: type,
    quantity: quantity,
    note: note,
  );
}
