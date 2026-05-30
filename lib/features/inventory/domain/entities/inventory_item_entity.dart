import '../enums/stock_status.dart';

class InventoryItemEntity {
  final String id;
  final String name;
  final String category;
  final String unit;
  final double currentStock;
  final double minimumStock;
  final double costPrice;
  final bool active;

  const InventoryItemEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.currentStock,
    required this.minimumStock,
    required this.costPrice,
    this.active = true,
  });

  StockStatus get stockStatus {
    if (currentStock <= minimumStock * 0.5) return StockStatus.critical;
    if (currentStock <= minimumStock) return StockStatus.low;
    return StockStatus.normal;
  }

  InventoryItemEntity copyWith({
    String? id,
    String? name,
    String? category,
    String? unit,
    double? currentStock,
    double? minimumStock,
    double? costPrice,
    bool? active,
  }) {
    return InventoryItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      currentStock: currentStock ?? this.currentStock,
      minimumStock: minimumStock ?? this.minimumStock,
      costPrice: costPrice ?? this.costPrice,
      active: active ?? this.active,
    );
  }
}
