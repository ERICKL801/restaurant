import 'package:flutter/material.dart';
import '../../domain/entities/receipt_entity.dart';

class ReceiptPreviewCard extends StatelessWidget {
  final ReceiptEntity receipt;

  const ReceiptPreviewCard({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 48,
              color: Colors.green.shade600,
            ),
            const SizedBox(height: 12),
            Text(
              'Pago Exitoso',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 16),
            _ReceiptLine(
              label: 'Comprobante',
              value: receipt.receiptNumber,
              theme: theme,
            ),
            const SizedBox(height: 4),
            _ReceiptLine(
              label: 'Fecha',
              value:
                  '${receipt.issuedAt.day}/${receipt.issuedAt.month}/${receipt.issuedAt.year} ${receipt.issuedAt.hour}:${receipt.issuedAt.minute.toString().padLeft(2, '0')}',
              theme: theme,
            ),
            const Divider(height: 24),
            _ReceiptLine(
              label: 'Subtotal',
              value: 'S/ ${receipt.subtotal.toStringAsFixed(2)}',
              theme: theme,
            ),
            const SizedBox(height: 4),
            _ReceiptLine(
              label: 'IGV (18%)',
              value: 'S/ ${receipt.tax.toStringAsFixed(2)}',
              theme: theme,
            ),
            const Divider(height: 24),
            _ReceiptLine(
              label: 'Total',
              value: 'S/ ${receipt.total.toStringAsFixed(2)}',
              theme: theme,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptLine extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;
  final bool isBold;

  const _ReceiptLine({
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
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : null,
          ),
        ),
      ],
    );
  }
}
