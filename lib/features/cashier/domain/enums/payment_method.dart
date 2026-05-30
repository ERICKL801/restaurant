import 'package:flutter/material.dart';

enum PaymentMethod {
  cash('cash', 'Efectivo', Icons.money_rounded),
  card('card', 'Tarjeta', Icons.credit_card_rounded),
  yape('yape', 'Yape', Icons.qr_code_scanner_rounded),
  plin('plin', 'Plin', Icons.qr_code_scanner_rounded),
  transfer('transfer', 'Transferencia', Icons.account_balance_rounded);

  final String value;
  final String displayName;
  final IconData icon;
  const PaymentMethod(this.value, this.displayName, this.icon);

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (m) => m.value == value,
      orElse: () => PaymentMethod.cash,
    );
  }
}
