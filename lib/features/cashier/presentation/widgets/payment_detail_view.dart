import 'package:flutter/material.dart';
import '../../../orders/domain/entities/order_item_entity.dart';
import '../../domain/enums/payment_method.dart';
import '../providers/payment_detail_provider.dart';
import 'payment_method_selector.dart';
import 'payment_summary_card.dart';
import 'receipt_preview_card.dart';

class PaymentDetailView extends StatelessWidget {
  final PaymentDetailState state;
  final void Function(PaymentMethod) onSelectMethod;
  final VoidCallback onProcessPayment;
  final VoidCallback onReset;

  const PaymentDetailView({
    super.key,
    required this.state,
    required this.onSelectMethod,
    required this.onProcessPayment,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.items.isEmpty) {
      return Center(child: Text('Error: ${state.error}'));
    }

    if (state.isCompleted && state.receipt != null) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ReceiptPreviewCard(receipt: state.receipt!),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onReset,
              icon: const Icon(Icons.receipt_long_rounded),
              label: const Text('Nuevo Cobro'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.tableName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pedido: ${state.orderId}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Productos',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...state.items.map((item) => _OrderItemRow(
                item: item,
                theme: theme,
              )),
          const SizedBox(height: 16),
          PaymentSummaryCard(
            subtotal: state.subtotal,
            tax: state.tax,
            total: state.total,
          ),
          const SizedBox(height: 20),
          PaymentMethodSelector(
            selected: state.selectedMethod,
            onSelected: onSelectMethod,
          ),
          if (state.error != null) ...[
            const SizedBox(height: 12),
            Text(
              state.error!,
              style: TextStyle(color: theme.colorScheme.error, fontSize: 13),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: state.selectedMethod != null && !state.isProcessing
                  ? onProcessPayment
                  : null,
              icon: state.isProcessing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.payments_rounded),
              label: Text(
                state.isProcessing
                    ? 'Procesando...'
                    : 'Cobrar S/ ${state.total.toStringAsFixed(2)}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderItemEntity item;
  final ThemeData theme;

  const _OrderItemRow({
    required this.item,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            '${item.quantity}x',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.menuItem.name, style: const TextStyle(fontSize: 13)),
                if (item.note.isNotEmpty)
                  Text(
                    item.note,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.amber.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            'S/ ${item.subtotal.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
