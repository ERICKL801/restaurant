import 'package:flutter/material.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/enums/stock_status.dart';
import 'stock_status_chip.dart';

class InventoryCard extends StatelessWidget {
  final InventoryItemEntity item;
  final VoidCallback? onTap;

  const InventoryCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = item.stockStatus;
    final borderColor = status == StockStatus.critical
        ? Colors.red
        : status == StockStatus.low
            ? Colors.orange
            : Colors.green;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  StockStatusChip(status: status),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                item.category,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${item.currentStock.toStringAsFixed(item.currentStock == item.currentStock.roundToDouble() ? 0 : 1)} ${item.unit}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: borderColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Stock mín: ${item.minimumStock.toStringAsFixed(item.minimumStock == item.minimumStock.roundToDouble() ? 0 : 1)} ${item.unit}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
