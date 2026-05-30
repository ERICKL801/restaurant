import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/enums/movement_type.dart';
import '../providers/inventory_detail_provider.dart';
import '../providers/inventory_provider.dart';
import '../widgets/inventory_card.dart';
import '../widgets/inventory_detail_view.dart';
import '../widgets/inventory_filter_bar.dart';
import '../widgets/inventory_search_bar.dart';
import '../widgets/movement_form_dialog.dart';

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key});

  @override
  ConsumerState<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<InventoryPage> {
  String? _selectedItemId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(inventoryProvider.notifier).loadItems();
    });
  }

  void _onSelectItem(InventoryItemEntity item) {
    final isDesktop = AppResponsive.isDesktop(context);

    if (isDesktop) {
      setState(() => _selectedItemId = item.id);
      ref.read(inventoryDetailProvider.notifier).loadItem(item.id);
    } else {
      context.go(
        RoutePaths.inventoryItem.replaceAll(':id', item.id),
      );
    }
  }

  Future<void> _showMovementDialog(String itemName, String unit) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => MovementFormDialog(itemName: itemName, unit: unit),
    );

    if (result != null && _selectedItemId != null) {
      await ref.read(inventoryDetailProvider.notifier).registerMovement(
            itemId: _selectedItemId!,
            type: result['type'] as MovementType,
            quantity: result['quantity'] as double,
            note: result['note'] as String,
          );
      await ref.read(inventoryProvider.notifier).loadItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryProvider);
    final detailState = ref.watch(inventoryDetailProvider);
    final theme = Theme.of(context);
    final isDesktop = AppResponsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        actions: [
          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Actualizar',
            onPressed: () => ref.read(inventoryProvider.notifier).loadItems(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Volver',
            onPressed: () => context.go(RoutePaths.dashboard),
          ),
        ],
      ),
      body: isDesktop
          ? _buildDesktopLayout(state, detailState, theme)
          : _buildMobileLayout(state, theme),
    );
  }

  Widget _buildMobileLayout(InventoryState state, ThemeData theme) {
    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text('Error al cargar inventario',
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () =>
                  ref.read(inventoryProvider.notifier).loadItems(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        InventorySearchBar(
          query: state.searchQuery,
          onChanged: (q) =>
              ref.read(inventoryProvider.notifier).setSearch(q),
        ),
        InventoryFilterBar(
          categories: state.categories,
          selectedCategory: state.categoryFilter,
          selectedStatus: state.statusFilter,
          onCategoryChanged: (cat) =>
              ref.read(inventoryProvider.notifier).setCategoryFilter(cat),
          onStatusChanged: (status) =>
              ref.read(inventoryProvider.notifier).setStatusFilter(status),
        ),
        Expanded(
          child: state.filteredItems.isEmpty
              ? Center(
                  child: Text(
                    'No se encontraron insumos',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: state.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = state.filteredItems[index];
                    return InventoryCard(
                      item: item,
                      onTap: () => _onSelectItem(item),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    InventoryState state,
    InventoryDetailState detailState,
    ThemeData theme,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 420,
          child: Column(
            children: [
              InventorySearchBar(
                query: state.searchQuery,
                onChanged: (q) =>
                    ref.read(inventoryProvider.notifier).setSearch(q),
              ),
              InventoryFilterBar(
                categories: state.categories,
                selectedCategory: state.categoryFilter,
                selectedStatus: state.statusFilter,
                onCategoryChanged: (cat) =>
                    ref.read(inventoryProvider.notifier).setCategoryFilter(cat),
                onStatusChanged: (status) =>
                    ref.read(inventoryProvider.notifier).setStatusFilter(status),
              ),
              Expanded(
                child: state.error != null
                    ? Center(child: Text('Error: ${state.error!}'))
                    : state.filteredItems.isEmpty
                        ? Center(
                            child: Text(
                              'No se encontraron insumos',
                              style: TextStyle(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.4),
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: state.filteredItems.length,
                            itemBuilder: (context, index) {
                              final item = state.filteredItems[index];
                              return InventoryCard(
                                item: item,
                                onTap: () => _onSelectItem(item),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        Expanded(
          child: _selectedItemId == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_rounded,
                        size: 64,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Seleccione un insumo',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                )
              : InventoryDetailView(
                  state: detailState,
                  onAddMovement: () {
                    if (detailState.item != null) {
                      _showMovementDialog(
                        detailState.item!.name,
                        detailState.item!.unit,
                      );
                    }
                  },
                ),
        ),
      ],
    );
  }
}
