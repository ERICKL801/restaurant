class ReceiptEntity {
  final String receiptNumber;
  final String orderId;
  final String paymentId;
  final DateTime issuedAt;
  final double subtotal;
  final double tax;
  final double total;

  const ReceiptEntity({
    required this.receiptNumber,
    required this.orderId,
    required this.paymentId,
    required this.issuedAt,
    required this.subtotal,
    required this.tax,
    required this.total,
  });
}
