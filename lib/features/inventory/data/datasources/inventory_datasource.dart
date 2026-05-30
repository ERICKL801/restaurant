import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/entities/stock_movement_entity.dart';
import '../../domain/enums/movement_type.dart';

abstract class InventoryDatasource {
  Future<List<InventoryItemEntity>> getItems();
  Future<InventoryItemEntity?> getItemById(String id);
  Future<List<StockMovementEntity>> getMovements(String itemId);
  Future<InventoryItemEntity> registerMovement({
    required String itemId,
    required MovementType type,
    required double quantity,
    required String note,
  });
}
