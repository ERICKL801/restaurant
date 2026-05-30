enum PaymentStatus {
  pending('pending'),
  paid('paid'),
  cancelled('cancelled'),
  refunded('refunded');

  final String value;
  const PaymentStatus(this.value);

  String get displayName {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pendiente';
      case PaymentStatus.paid:
        return 'Pagado';
      case PaymentStatus.cancelled:
        return 'Anulado';
      case PaymentStatus.refunded:
        return 'Reembolsado';
    }
  }

  static PaymentStatus fromString(String value) {
    return PaymentStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => PaymentStatus.pending,
    );
  }
}
