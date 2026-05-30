import 'package:flutter/material.dart';
import '../../domain/enums/stock_status.dart';

class InventoryFilterBar extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final StockStatus? selectedStatus;
  final void Function(String?) onCategoryChanged;
  final void Function(StockStatus?) onStatusChanged;

  const InventoryFilterBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.selectedStatus,
    required this.onCategoryChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _Chip(
                  label: 'Todas',
                  selected: selectedCategory == null && selectedStatus == null,
                  onTap: () {
                    onCategoryChanged(null);
                    onStatusChanged(null);
                  },
                ),
                const SizedBox(width: 8),
                ...categories.map((cat) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _Chip(
                        label: cat,
                        selected: selectedCategory == cat,
                        onTap: () => onCategoryChanged(
                          selectedCategory == cat ? null : cat,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 32,
            child: Row(
              children: [
                _SmallChip(
                  label: StockStatus.normal.displayName,
                  color: Colors.green,
                  selected: selectedStatus == StockStatus.normal,
                  onTap: () => onStatusChanged(
                    selectedStatus == StockStatus.normal ? null : StockStatus.normal,
                  ),
                ),
                const SizedBox(width: 8),
                _SmallChip(
                  label: StockStatus.low.displayName,
                  color: Colors.orange,
                  selected: selectedStatus == StockStatus.low,
                  onTap: () => onStatusChanged(
                    selectedStatus == StockStatus.low ? null : StockStatus.low,
                  ),
                ),
                const SizedBox(width: 8),
                _SmallChip(
                  label: StockStatus.critical.displayName,
                  color: Colors.red,
                  selected: selectedStatus == StockStatus.critical,
                  onTap: () => onStatusChanged(
                    selectedStatus == StockStatus.critical
                        ? null
                        : StockStatus.critical,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            color: selected ? theme.colorScheme.onPrimaryContainer : null,
          ),
        ),
      ),
    );
  }
}

class _SmallChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _SmallChip({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : color.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            color: selected ? color : color.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
