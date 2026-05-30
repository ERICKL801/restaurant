import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/menu_category_entity.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/orders_local_datasource.dart';

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepositoryImpl(ref.watch(ordersLocalDataSourceProvider));
});

class MenuRepositoryImpl implements MenuRepository {
  final OrdersLocalDataSource _dataSource;

  MenuRepositoryImpl(this._dataSource);

  @override
  Future<List<MenuCategoryEntity>> getCategories() async {
    final models = _dataSource.getCategories();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<MenuItemEntity>> getMenuItems() async {
    final models = _dataSource.getMenuItems();
    return models.map((m) => m.toEntity()).toList();
  }
}
