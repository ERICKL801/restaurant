import 'realtime_event.dart';

class InventoryUpdatedEvent extends RealtimeEvent {
  final String itemId;
  final String itemName;
  final double newStock;
  final String movementType;

  InventoryUpdatedEvent({
    required this.itemId,
    required this.itemName,
    required this.newStock,
    required this.movementType,
  });
}
