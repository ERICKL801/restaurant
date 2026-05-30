import '../enums/table_status.dart';

class TableEntity {
  final String id;
  final String name;
  final int capacity;
  final TableStatus status;

  const TableEntity({
    required this.id,
    required this.name,
    required this.capacity,
    required this.status,
  });

  TableEntity copyWith({
    String? id,
    String? name,
    int? capacity,
    TableStatus? status,
  }) {
    return TableEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
    );
  }
}
