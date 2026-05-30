import 'menu_item_entity.dart';

class OrderItemEntity {
  final MenuItemEntity menuItem;
  final int quantity;
  final String note;

  const OrderItemEntity({
    required this.menuItem,
    this.quantity = 1,
    this.note = '',
  });

  double get subtotal => menuItem.price * quantity;

  OrderItemEntity copyWith({
    MenuItemEntity? menuItem,
    int? quantity,
    String? note,
  }) {
    return OrderItemEntity(
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
    );
  }
}
