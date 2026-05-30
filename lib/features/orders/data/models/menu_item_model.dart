import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/menu_item_entity.dart';

part 'menu_item_model.freezed.dart';
part 'menu_item_model.g.dart';

@freezed
class MenuItemModel with _$MenuItemModel {
  const factory MenuItemModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String categoryId,
    String? imageUrl,
    @Default(true) bool available,
  }) = _MenuItemModel;

  const MenuItemModel._();

  factory MenuItemModel.fromJson(Map<String, dynamic> json) =>
      _$MenuItemModelFromJson(json);

  factory MenuItemModel.fromEntity(MenuItemEntity entity) =>
      MenuItemModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        price: entity.price,
        categoryId: entity.categoryId,
        imageUrl: entity.imageUrl,
        available: entity.available,
      );

  MenuItemEntity toEntity() => MenuItemEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        categoryId: categoryId,
        imageUrl: imageUrl,
        available: available,
      );
}
