enum StockStatus {
  normal('normal', 'Normal'),
  low('low', 'Stock Bajo'),
  critical('critical', 'Crítico');

  final String value;
  final String displayName;
  const StockStatus(this.value, this.displayName);

  static StockStatus fromString(String value) {
    return StockStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => StockStatus.normal,
    );
  }
}
