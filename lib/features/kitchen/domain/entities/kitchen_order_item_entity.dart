class KitchenOrderItemEntity {
  final String name;
  final int quantity;
  final String note;

  const KitchenOrderItemEntity({
    required this.name,
    required this.quantity,
    this.note = '',
  });
}
