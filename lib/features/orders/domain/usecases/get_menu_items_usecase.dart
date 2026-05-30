import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/menu_item_entity.dart';
import '../repositories/menu_repository.dart';
import '../../data/repositories/menu_repository_impl.dart';

final getMenuItemsUseCaseProvider = Provider<GetMenuItemsUseCase>((ref) {
  return GetMenuItemsUseCase(ref.watch(menuRepositoryProvider));
});

class GetMenuItemsUseCase {
  final MenuRepository _repository;

  GetMenuItemsUseCase(this._repository);

  Future<List<MenuItemEntity>> call() {
    return _repository.getMenuItems();
  }
}
