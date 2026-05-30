import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/menu_category_entity.dart';
import '../repositories/menu_repository.dart';
import '../../data/repositories/menu_repository_impl.dart';

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  return GetCategoriesUseCase(ref.watch(menuRepositoryProvider));
});

class GetCategoriesUseCase {
  final MenuRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<MenuCategoryEntity>> call() {
    return _repository.getCategories();
  }
}
