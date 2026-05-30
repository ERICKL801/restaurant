import 'package:flutter/material.dart';
import '../../domain/entities/menu_item_entity.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItemEntity item;
  final bool isGrid;
  final VoidCallback onAdd;
  final int? orderQuantity;

  const MenuItemCard({
    super.key,
    required this.item,
    this.isGrid = false,
    required this.onAdd,
    this.orderQuantity,
  });

  @override
  Widget build(BuildContext context) {
    if (isGrid) return _buildGridCard(context);
    return _buildListCard(context);
  }

  Widget _buildListCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.restaurant_rounded,
                color: colorScheme.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (item.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '\$${item.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.primary,
                  ),
            ),
            const SizedBox(width: 8),
            _AddButton(
              onTap: onAdd,
              quantity: orderQuantity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.restaurant_rounded,
                color: colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              item.description,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary,
                      ),
                ),
                _AddButton(
                  onTap: onAdd,
                  quantity: orderQuantity,
                  compact: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final int? quantity;
  final bool compact;

  const _AddButton({
    required this.onTap,
    this.quantity,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (quantity != null && quantity! > 0) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 8,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_checkout, size: compact ? 12 : 14, color: colorScheme.onPrimary),
            const SizedBox(width: 4),
            Text(
              '$quantity',
              style: TextStyle(
                fontSize: compact ? 11 : 12,
                fontWeight: FontWeight.w700,
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: compact ? 32 : 36,
          height: compact ? 32 : 36,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.add_rounded,
            size: compact ? 18 : 20,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
