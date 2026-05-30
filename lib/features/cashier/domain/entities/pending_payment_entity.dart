class PendingPaymentEntity {
  final String orderId;
  final String tableId;
  final String tableName;
  final double total;
  final DateTime createdAt;
  final int itemCount;

  const PendingPaymentEntity({
    required this.orderId,
    required this.tableId,
    required this.tableName,
    required this.total,
    required this.createdAt,
    required this.itemCount,
  });
}
