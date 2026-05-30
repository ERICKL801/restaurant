enum TableStatus {
  available('available'),
  occupied('occupied'),
  waitingPayment('waitingPayment'),
  reserved('reserved');

  final String value;
  const TableStatus(this.value);

  static TableStatus fromString(String value) {
    return TableStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => TableStatus.available,
    );
  }
}
