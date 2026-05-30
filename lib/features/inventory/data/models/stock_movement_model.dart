import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/stock_movement_entity.dart';
import '../../domain/enums/movement_type.dart';

part 'stock_movement_model.freezed.dart';
part 'stock_movement_model.g.dart';

@freezed
class StockMovementModel with _$StockMovementModel {
  const factory StockMovementModel({
    required String id,
    required String inventoryItemId,
    required MovementType movementType,
    required double quantity,
    @Default(0.0) double previousStock,
    @Default(0.0) double currentStock,
    required DateTime createdAt,
    @Default('') String note,
  }) = _StockMovementModel;

  const StockMovementModel._();

  factory StockMovementModel.fromJson(Map<String, dynamic> json) =>
      _$StockMovementModelFromJson(json);

  StockMovementEntity toEntity() => StockMovementEntity(
        id: id,
        inventoryItemId: inventoryItemId,
        movementType: movementType,
        quantity: quantity,
        previousStock: previousStock,
        currentStock: currentStock,
        createdAt: createdAt,
        note: note,
      );
}
