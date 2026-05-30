import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/menu_category_entity.dart';

part 'menu_category_model.freezed.dart';
part 'menu_category_model.g.dart';

@freezed
class MenuCategoryModel with _$MenuCategoryModel {
  const factory MenuCategoryModel({
    required String id,
    required String name,
  }) = _MenuCategoryModel;

  const MenuCategoryModel._();

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MenuCategoryModelFromJson(json);

  factory MenuCategoryModel.fromEntity(MenuCategoryEntity entity) =>
      MenuCategoryModel(id: entity.id, name: entity.name);

  MenuCategoryEntity toEntity() =>
      MenuCategoryEntity(id: id, name: name);
}
