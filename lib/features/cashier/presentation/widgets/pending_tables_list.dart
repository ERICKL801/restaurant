import 'package:flutter/material.dart';
import '../../domain/entities/pending_payment_entity.dart';

class PendingTablesList extends StatelessWidget {
  final List<PendingPaymentEntity> pendingPayments;
  final void Function(PendingPaymentEntity) onTap;
  final String? selectedOrderId;

  const PendingTablesList({
    super.key,
    required this.pendingPayments,
    required this.onTap,
    this.selectedOrderId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (pendingPayments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.payments_rounded,
              size: 64,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay cuentas pendientes',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: pendingPayments.length,
      itemBuilder: (context, index) {
        final payment = pendingPayments[index];
        final isSelected = payment.orderId == selectedOrderId;
        final elapsed = DateTime.now().difference(payment.createdAt);

        return Card(
          color: isSelected
              ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
              : null,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.errorContainer,
              child: Icon(
                Icons.receipt_rounded,
                color: theme.colorScheme.error,
              ),
            ),
            title: Text(
              payment.tableName,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '${payment.itemCount} ${payment.itemCount == 1 ? 'producto' : 'productos'} · ${elapsed.inMinutes} min',
            ),
            trailing: Text(
              'S/ ${payment.total.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            onTap: () => onTap(payment),
          ),
        );
      },
    );
  }
}
