import 'package:flutter/material.dart';

class PaymentSummaryCard extends StatelessWidget {
  final double subtotal;
  final double tax;
  final double total;

  const PaymentSummaryCard({
    super.key,
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SummaryRow(
              label: 'Subtotal',
              value: subtotal,
              theme: theme,
            ),
            const SizedBox(height: 8),
            _SummaryRow(
              label: 'IGV (18%)',
              value: tax,
              theme: theme,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(),
            ),
            _SummaryRow(
              label: 'Total',
              value: total,
              theme: theme,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final ThemeData theme;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.theme,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          'S/ ${value.toStringAsFixed(2)}',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : null,
            color: isBold ? theme.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
