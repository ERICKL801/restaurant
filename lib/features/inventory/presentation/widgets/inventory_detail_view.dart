import 'package:flutter/material.dart';
import '../providers/inventory_detail_provider.dart';
import 'movement_history_list.dart';
import 'stock_status_chip.dart';

class InventoryDetailView extends StatelessWidget {
  final InventoryDetailState state;
  final VoidCallback onAddMovement;

  const InventoryDetailView({
    super.key,
    required this.state,
    required this.onAddMovement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.item == null) {
      return const Center(child: Text('Insumo no encontrado'));
    }

    final item = state.item!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      StockStatusChip(status: item.stockStatus),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.category,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _InfoTile(
                        label: 'Stock Actual',
                        value:
                            '${item.currentStock.toStringAsFixed(item.currentStock == item.currentStock.roundToDouble() ? 0 : 1)} ${item.unit}',
                        theme: theme,
                      ),
                      const SizedBox(width: 16),
                      _InfoTile(
                        label: 'Stock Mínimo',
                        value:
                            '${item.minimumStock.toStringAsFixed(item.minimumStock == item.minimumStock.roundToDouble() ? 0 : 1)} ${item.unit}',
                        theme: theme,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _InfoTile(
                    label: 'Costo por ${item.unit}',
                    value: 'S/ ${item.costPrice.toStringAsFixed(2)}',
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Historial de Movimientos',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              FilledButton.tonalIcon(
                onPressed: state.isProcessing ? null : onAddMovement,
                icon: state.isProcessing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add_rounded, size: 18),
                label: const Text('Movimiento'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 300,
            child: MovementHistoryList(movements: state.movements),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
