import 'package:flutter/material.dart';
import '../../domain/entities/kitchen_order_entity.dart';
import '../../domain/enums/kitchen_order_status.dart';
import 'kitchen_order_card.dart';

class KitchenColumn extends StatelessWidget {
  final String title;
  final KitchenOrderStatus status;
  final Color color;
  final List<KitchenOrderEntity> orders;
  final void Function(String orderId) onAdvance;

  const KitchenColumn({
    super.key,
    required this.title,
    required this.status,
    required this.color,
    required this.orders,
    required this.onAdvance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${orders.length}',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: orders.isEmpty
                ? Center(
                    child: Text(
                      'Sin pedidos',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                        fontSize: 13,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return KitchenOrderCard(
                        order: order,
                        onAdvance: order.status.nextStatus != null
                            ? () => onAdvance(order.id)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
