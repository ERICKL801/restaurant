import '../enums/movement_type.dart';

class StockMovementEntity {
  final String id;
  final String inventoryItemId;
  final MovementType movementType;
  final double quantity;
  final double previousStock;
  final double currentStock;
  final DateTime createdAt;
  final String note;

  const StockMovementEntity({
    required this.id,
    required this.inventoryItemId,
    required this.movementType,
    required this.quantity,
    required this.previousStock,
    required this.currentStock,
    required this.createdAt,
    this.note = '',
  });
}
