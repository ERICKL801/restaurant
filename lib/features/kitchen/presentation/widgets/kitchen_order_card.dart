import 'package:flutter/material.dart';
import '../../domain/entities/kitchen_order_entity.dart';
import '../../domain/enums/kitchen_order_status.dart';
import 'kitchen_status_chip.dart';
import 'order_timer.dart';

class KitchenOrderCard extends StatelessWidget {
  final KitchenOrderEntity order;
  final VoidCallback? onAdvance;

  const KitchenOrderCard({
    super.key,
    required this.order,
    this.onAdvance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.table_restaurant_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  order.tableName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                KitchenStatusChip(status: order.status),
              ],
            ),
            const SizedBox(height: 6),
            OrderTimer(createdAt: order.createdAt),
            const SizedBox(height: 8),
            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.quantity}x ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                )),
            if (order.items.any((i) => i.note.isNotEmpty)) ...[
              const SizedBox(height: 4),
              ...order.items
                  .where((i) => i.note.isNotEmpty)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.notes_rounded,
                              size: 12,
                              color: Colors.amber.shade700,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${item.name}: ${item.note}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.amber.shade700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
            ],
            const Divider(height: 16),
            Row(
              children: [
                Text(
                  'Total: S/ ${order.total.toStringAsFixed(2)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (onAdvance != null)
                  FilledButton.tonalIcon(
                    onPressed: onAdvance,
                    icon: Icon(_nextIcon, size: 16),
                    label: Text(
                      _nextLabel,
                      style: const TextStyle(fontSize: 12),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData get _nextIcon {
    switch (order.status) {
      case KitchenOrderStatus.sent:
        return Icons.restaurant_menu_rounded;
      case KitchenOrderStatus.preparing:
        return Icons.check_circle_outline_rounded;
      case KitchenOrderStatus.ready:
        return Icons.delivery_dining_rounded;
      case KitchenOrderStatus.delivered:
        return Icons.check_circle_rounded;
    }
  }

  String get _nextLabel {
    switch (order.status) {
      case KitchenOrderStatus.sent:
        return 'Preparar';
      case KitchenOrderStatus.preparing:
        return 'Listo';
      case KitchenOrderStatus.ready:
        return 'Entregar';
      case KitchenOrderStatus.delivered:
        return '';
    }
  }
}
