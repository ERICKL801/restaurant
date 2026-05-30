import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/enums/stock_status.dart';

part 'inventory_item_model.freezed.dart';
part 'inventory_item_model.g.dart';

@freezed
class InventoryItemModel with _$InventoryItemModel {
  const factory InventoryItemModel({
    required String id,
    required String name,
    required String category,
    required String unit,
    @Default(0.0) double currentStock,
    @Default(0.0) double minimumStock,
    @Default(0.0) double costPrice,
    @Default(true) bool active,
  }) = _InventoryItemModel;

  const InventoryItemModel._();

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemModelFromJson(json);

  StockStatus get stockStatus {
    if (currentStock <= minimumStock * 0.5) return StockStatus.critical;
    if (currentStock <= minimumStock) return StockStatus.low;
    return StockStatus.normal;
  }

  InventoryItemEntity toEntity() => InventoryItemEntity(
        id: id,
        name: name,
        category: category,
        unit: unit,
        currentStock: currentStock,
        minimumStock: minimumStock,
        costPrice: costPrice,
        active: active,
      );
}
