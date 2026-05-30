import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/menu_category_entity.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_menu_items_usecase.dart';

final menuProvider = StateNotifierProvider<MenuNotifier, MenuState>((ref) {
  return MenuNotifier(
    ref.watch(getCategoriesUseCaseProvider),
    ref.watch(getMenuItemsUseCaseProvider),
  );
});

class MenuState {
  final List<MenuCategoryEntity> categories;
  final List<MenuItemEntity> items;
  final String? selectedCategoryId;
  final bool isLoading;
  final String? error;

  const MenuState({
    this.categories = const [],
    this.items = const [],
    this.selectedCategoryId,
    this.isLoading = false,
    this.error,
  });

  List<MenuItemEntity> get filteredItems {
    if (selectedCategoryId == null) return items;
    return items.where((i) => i.categoryId == selectedCategoryId).toList();
  }

  MenuState copyWith({
    List<MenuCategoryEntity>? categories,
    List<MenuItemEntity>? items,
    String? selectedCategoryId,
    bool? isLoading,
    String? error,
  }) {
    return MenuState(
      categories: categories ?? this.categories,
      items: items ?? this.items,
      selectedCategoryId: selectedCategoryId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class MenuNotifier extends StateNotifier<MenuState> {
  final GetCategoriesUseCase _getCategories;
  final GetMenuItemsUseCase _getMenuItems;

  MenuNotifier(this._getCategories, this._getMenuItems)
      : super(const MenuState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final categories = await _getCategories();
      final items = await _getMenuItems();
      state = state.copyWith(
        categories: categories,
        items: items,
        isLoading: false,
        selectedCategoryId: categories.isNotEmpty ? categories.first.id : null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void selectCategory(String? categoryId) {
    state = state.copyWith(selectedCategoryId: categoryId);
  }
}
