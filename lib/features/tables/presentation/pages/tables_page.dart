import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/enums/table_status.dart';
import '../providers/tables_provider.dart';
import '../widgets/tables_grid.dart';

class TablesPage extends ConsumerStatefulWidget {
  const TablesPage({super.key});

  @override
  ConsumerState<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends ConsumerState<TablesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(tablesProvider.notifier).loadTables());
  }

  Future<void> _onRefresh() async {
    await ref.read(tablesProvider.notifier).loadTables();
  }

  void _onTableTap(TableEntity table) {
    context.go(
      RoutePaths.orders.replaceAll(':tableId', table.id),
      extra: {'tableName': table.name},
    );
  }

  void _onTableLongPress(TableEntity table) async {
    final newStatus = await showModalBottomSheet<TableStatus>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _StatusSheet(table: table),
    );

    if (newStatus != null && newStatus != table.status && mounted) {
      await ref.read(tablesProvider.notifier).updateStatus(
            tableId: table.id,
            status: newStatus,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tablesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesas'),
        actions: [
          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          _FilterBar(
            activeFilter: state.filter,
            totalCount: state.totalCount,
            onFilterChanged: (filter) {
              ref.read(tablesProvider.notifier).setFilter(filter);
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child:               TablesGrid(
                tables: state.filteredTables,
                onTableTap: _onTableTap,
                onTableLongPress: _onTableLongPress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final TableStatus? activeFilter;
  final int totalCount;
  final ValueChanged<TableStatus?> onFilterChanged;

  const _FilterBar({
    required this.activeFilter,
    required this.totalCount,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      _FilterChipData(null, 'Todas', totalCount, null),
      _FilterChipData(
        TableStatus.available,
        'Disponibles',
        null,
        Theme.of(context).colorScheme.error,
      ),
      _FilterChipData(
        TableStatus.occupied,
        'Ocupadas',
        null,
        Theme.of(context).colorScheme.primary,
      ),
      _FilterChipData(
        TableStatus.waitingPayment,
        'Esperando Pago',
        null,
        Theme.of(context).colorScheme.secondary,
      ),
      const _FilterChipData(
        TableStatus.reserved,
        'Reservadas',
        null,
        Colors.blue,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context)
                .colorScheme
                .outline
                .withValues(alpha: 0.2),
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((f) {
            final isActive = activeFilter == f.status;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(f.label),
                selected: isActive,
                onSelected: (_) => onFilterChanged(
                  isActive ? null : f.status,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _FilterChipData {
  final TableStatus? status;
  final String label;
  final int? count;
  final Color? color;

  const _FilterChipData(this.status, this.label, this.count, this.color);
}

class _StatusSheet extends StatelessWidget {
  final TableEntity table;
  const _StatusSheet({required this.table});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'Cambiar estado de ${table.name}',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ...TableStatus.values.map((status) {
            final isCurrent = status == table.status;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FilledButton.tonal(
                onPressed: isCurrent
                    ? null
                    : () => Navigator.pop(context, status),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _statusIcon(status),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _statusLabel(status),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    if (isCurrent)
                      Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  IconData _statusIcon(TableStatus status) {
    switch (status) {
      case TableStatus.available:
        return Icons.check_circle_outline;
      case TableStatus.occupied:
        return Icons.block;
      case TableStatus.waitingPayment:
        return Icons.payment_outlined;
      case TableStatus.reserved:
        return Icons.bookmark_outline;
    }
  }

  String _statusLabel(TableStatus status) {
    switch (status) {
      case TableStatus.available:
        return 'Disponible';
      case TableStatus.occupied:
        return 'Ocupada';
      case TableStatus.waitingPayment:
        return 'Esperando Pago';
      case TableStatus.reserved:
        return 'Reservada';
    }
  }
}
