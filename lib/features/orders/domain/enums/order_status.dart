enum OrderStatus {
  draft('draft'),
  sent('sent'),
  preparing('preparing'),
  completed('completed'),
  cancelled('cancelled');

  final String value;
  const OrderStatus(this.value);

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => OrderStatus.draft,
    );
  }
}
