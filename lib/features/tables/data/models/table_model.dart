import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/enums/table_status.dart';

part 'table_model.freezed.dart';
part 'table_model.g.dart';

@freezed
class TableModel with _$TableModel {
  const factory TableModel({
    required String id,
    required String name,
    required int capacity,
    required String status,
  }) = _TableModel;

  const TableModel._();

  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);

  factory TableModel.fromEntity(TableEntity entity) => TableModel(
        id: entity.id,
        name: entity.name,
        capacity: entity.capacity,
        status: entity.status.value,
      );

  TableEntity toEntity() => TableEntity(
        id: id,
        name: name,
        capacity: capacity,
        status: TableStatus.fromString(status),
      );
}
