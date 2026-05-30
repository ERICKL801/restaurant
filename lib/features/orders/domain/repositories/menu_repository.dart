import '../entities/menu_category_entity.dart';
import '../entities/menu_item_entity.dart';

abstract class MenuRepository {
  Future<List<MenuCategoryEntity>> getCategories();
  Future<List<MenuItemEntity>> getMenuItems();
}
