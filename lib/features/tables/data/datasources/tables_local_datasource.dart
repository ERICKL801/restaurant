import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/table_model.dart';

final tablesLocalDataSourceProvider = Provider<TablesLocalDataSource>((ref) {
  return TablesLocalDataSource();
});

class TablesLocalDataSource {
  List<TableModel> _tables = [];

  TablesLocalDataSource() {
    _tables = _mockTables;
  }

  Future<List<TableModel>> getTables() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_tables);
  }

  Future<TableModel> updateStatus({
    required String tableId,
    required String status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final index = _tables.indexWhere((t) => t.id == tableId);
    if (index == -1) {
      throw Exception('Mesa no encontrada');
    }

    _tables[index] = _tables[index].copyWith(status: status);
    return _tables[index];
  }

  static final List<TableModel> _mockTables = [
    const TableModel(id: '1', name: 'Mesa 1', capacity: 2, status: 'available'),
    const TableModel(id: '2', name: 'Mesa 2', capacity: 4, status: 'occupied'),
    const TableModel(id: '3', name: 'Mesa 3', capacity: 4, status: 'available'),
    const TableModel(id: '4', name: 'Mesa 4', capacity: 6, status: 'reserved'),
    const TableModel(id: '5', name: 'Mesa 5', capacity: 2, status: 'occupied'),
    const TableModel(id: '6', name: 'Mesa 6', capacity: 4, status: 'waitingPayment'),
    const TableModel(id: '7', name: 'Mesa 7', capacity: 8, status: 'available'),
    const TableModel(id: '8', name: 'Mesa 8', capacity: 4, status: 'reserved'),
    const TableModel(id: '9', name: 'VIP', capacity: 6, status: 'available'),
    const TableModel(id: '10', name: 'Terraza 1', capacity: 4, status: 'occupied'),
    const TableModel(id: '11', name: 'Terraza 2', capacity: 4, status: 'available'),
    const TableModel(id: '12', name: 'Barra', capacity: 2, status: 'available'),
    const TableModel(id: '13', name: 'Privado', capacity: 10, status: 'reserved'),
    const TableModel(id: '14', name: 'Mesa 14', capacity: 4, status: 'waitingPayment'),
  ];
}
