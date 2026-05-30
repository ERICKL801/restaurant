class MenuItemEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String? imageUrl;
  final bool available;

  const MenuItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    this.imageUrl,
    this.available = true,
  });
}
