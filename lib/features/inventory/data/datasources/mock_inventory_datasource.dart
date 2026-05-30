import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/entities/stock_movement_entity.dart';
import '../../domain/enums/movement_type.dart';
import '../models/inventory_item_model.dart';
import '../models/stock_movement_model.dart';
import 'inventory_datasource.dart';

final mockInventoryDatasourceProvider = Provider<InventoryDatasource>((ref) {
  return MockInventoryDatasource();
});

class MockInventoryDatasource implements InventoryDatasource {
  final List<InventoryItemModel> _items = [];
  final List<StockMovementModel> _movements = [];

  MockInventoryDatasource() {
    _initMockData();
  }

  void _initMockData() {
    _items.addAll(_mockItems);
    for (final item in _items) {
      _movements.add(
        StockMovementModel(
          id: 'mov-initial-${item.id}',
          inventoryItemId: item.id,
          movementType: MovementType.entry,
          quantity: item.currentStock,
          previousStock: 0,
          currentStock: item.currentStock,
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          note: 'Stock inicial',
        ),
      );
    }
  }

  @override
  Future<List<InventoryItemEntity>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _items.map((m) => m.toEntity()).toList();
  }

  @override
  Future<InventoryItemEntity?> getItemById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _items.firstWhere((i) => i.id == id).toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<StockMovementEntity>> getMovements(String itemId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _movements
        .where((m) => m.inventoryItemId == itemId)
        .map((m) => m.toEntity())
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<InventoryItemEntity> registerMovement({
    required String itemId,
    required MovementType type,
    required double quantity,
    required String note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _items.indexWhere((i) => i.id == itemId);
    if (index == -1) throw Exception('Insumo no encontrado');

    final item = _items[index];
    final previousStock = item.currentStock;
    final adjustedQty = type == MovementType.exit ? -quantity : quantity;
    final newStock = (previousStock + adjustedQty).clamp(0, double.infinity).toDouble();

    _items[index] = item.copyWith(currentStock: newStock);

    _movements.add(
      StockMovementModel(
        id: 'mov-${DateTime.now().millisecondsSinceEpoch}',
        inventoryItemId: itemId,
        movementType: type,
        quantity: quantity,
        previousStock: previousStock,
        currentStock: newStock,
        createdAt: DateTime.now(),
        note: note,
      ),
    );

    return _items[index].toEntity();
  }

  static const List<InventoryItemModel> _mockItems = [
    InventoryItemModel(id: 'inv-1', name: 'Arroz', category: 'Abarrotes', unit: 'kg', currentStock: 25, minimumStock: 10, costPrice: 3.50),
    InventoryItemModel(id: 'inv-2', name: 'Aceite Vegetal', category: 'Abarrotes', unit: 'L', currentStock: 8, minimumStock: 5, costPrice: 7.00),
    InventoryItemModel(id: 'inv-3', name: 'Pollo', category: 'Carnes', unit: 'kg', currentStock: 12, minimumStock: 8, costPrice: 11.00),
    InventoryItemModel(id: 'inv-4', name: 'Carne de Res', category: 'Carnes', unit: 'kg', currentStock: 3, minimumStock: 5, costPrice: 28.00),
    InventoryItemModel(id: 'inv-5', name: 'Tomate', category: 'Verduras', unit: 'kg', currentStock: 4, minimumStock: 5, costPrice: 4.00),
    InventoryItemModel(id: 'inv-6', name: 'Cebolla', category: 'Verduras', unit: 'kg', currentStock: 6, minimumStock: 5, costPrice: 2.50),
    InventoryItemModel(id: 'inv-7', name: 'Leche', category: 'Lácteos', unit: 'L', currentStock: 10, minimumStock: 6, costPrice: 4.50),
    InventoryItemModel(id: 'inv-8', name: 'Queso', category: 'Lácteos', unit: 'kg', currentStock: 1.5, minimumStock: 3, costPrice: 22.00),
    InventoryItemModel(id: 'inv-9', name: 'Azúcar', category: 'Abarrotes', unit: 'kg', currentStock: 15, minimumStock: 5, costPrice: 2.80),
    InventoryItemModel(id: 'inv-10', name: 'Café', category: 'Bebidas', unit: 'kg', currentStock: 2, minimumStock: 2, costPrice: 35.00),
    InventoryItemModel(id: 'inv-11', name: 'Papas', category: 'Verduras', unit: 'kg', currentStock: 20, minimumStock: 10, costPrice: 2.00),
    InventoryItemModel(id: 'inv-12', name: 'Limón', category: 'Verduras', unit: 'kg', currentStock: 1, minimumStock: 3, costPrice: 3.00),
    InventoryItemModel(id: 'inv-13', name: 'Ajo', category: 'Verduras', unit: 'kg', currentStock: 0.5, minimumStock: 1, costPrice: 12.00),
    InventoryItemModel(id: 'inv-14', name: 'Harina', category: 'Abarrotes', unit: 'kg', currentStock: 10, minimumStock: 5, costPrice: 3.00),
    InventoryItemModel(id: 'inv-15', name: 'Huevos', category: 'Abarrotes', unit: 'unid', currentStock: 60, minimumStock: 30, costPrice: 0.50),
    InventoryItemModel(id: 'inv-16', name: 'Mantequilla', category: 'Lácteos', unit: 'kg', currentStock: 2, minimumStock: 2, costPrice: 18.00),
    InventoryItemModel(id: 'inv-17', name: 'Sal', category: 'Abarrotes', unit: 'kg', currentStock: 8, minimumStock: 3, costPrice: 1.50),
    InventoryItemModel(id: 'inv-18', name: 'Pimienta', category: 'Abarrotes', unit: 'kg', currentStock: 0.8, minimumStock: 1, costPrice: 25.00),
    InventoryItemModel(id: 'inv-19', name: 'Fideos', category: 'Abarrotes', unit: 'kg', currentStock: 7, minimumStock: 4, costPrice: 3.20),
    InventoryItemModel(id: 'inv-20', name: 'Aceitunas', category: 'Abarrotes', unit: 'kg', currentStock: 1.2, minimumStock: 2, costPrice: 30.00),
    InventoryItemModel(id: 'inv-21', name: 'Pescado', category: 'Carnes', unit: 'kg', currentStock: 4, minimumStock: 4, costPrice: 25.00),
    InventoryItemModel(id: 'inv-22', name: 'Cerveza', category: 'Bebidas', unit: 'L', currentStock: 24, minimumStock: 12, costPrice: 5.00),
  ];
}
