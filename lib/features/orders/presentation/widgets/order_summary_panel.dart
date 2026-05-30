import 'package:flutter/material.dart';
import '../../domain/entities/order_item_entity.dart';
import 'order_item_tile.dart';

class OrderSummaryPanel extends StatelessWidget {
  final List<OrderItemEntity> items;
  final double total;
  final int itemCount;
  final bool isSending;
  final bool isSent;
  final bool hasItems;
  final String? lastOrderId;
  final void Function(String menuItemId) onIncrement;
  final void Function(String menuItemId) onDecrement;
  final void Function(String menuItemId) onRemove;
  final VoidCallback onSend;

  const OrderSummaryPanel({
    super.key,
    required this.items,
    required this.total,
    required this.itemCount,
    required this.isSending,
    required this.isSent,
    required this.hasItems,
    this.lastOrderId,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Resumen del Pedido',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              if (itemCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$itemCount',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 1),
        if (!hasItems)
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 40,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selecciona productos del menú',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.4),
                        ),
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return OrderItemTile(
                  item: item,
                  onIncrement: () => onIncrement(item.menuItem.id),
                  onDecrement: () => onDecrement(item.menuItem.id),
                  onRemove: () => onRemove(item.menuItem.id),
                );
              },
            ),
          ),
        if (isSent && lastOrderId != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 18, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pedido $lastOrderId enviado',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 48,
                child: FilledButton.icon(
                  onPressed: hasItems && !isSending ? onSend : null,
                  icon: isSending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send_rounded),
                  label: Text(
                    isSending ? 'Enviando...' : 'Enviar Pedido',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static void showAsBottomSheet(
    BuildContext context, {
    required List<OrderItemEntity> items,
    required double total,
    required int itemCount,
    required bool isSending,
    required bool isSent,
    required bool hasItems,
    String? lastOrderId,
    required void Function(String) onIncrement,
    required void Function(String) onDecrement,
    required void Function(String) onRemove,
    required VoidCallback onSend,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Expanded(
                child: OrderSummaryPanel(
                  items: items,
                  total: total,
                  itemCount: itemCount,
                  isSending: isSending,
                  isSent: isSent,
                  hasItems: hasItems,
                  lastOrderId: lastOrderId,
                  onIncrement: onIncrement,
                  onDecrement: onDecrement,
                  onRemove: onRemove,
                  onSend: onSend,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
