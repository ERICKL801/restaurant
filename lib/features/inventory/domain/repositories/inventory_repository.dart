import '../entities/inventory_item_entity.dart';
import '../entities/stock_movement_entity.dart';
import '../enums/movement_type.dart';

abstract class InventoryRepository {
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
