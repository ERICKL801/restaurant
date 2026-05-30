import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../../domain/entities/menu_category_entity.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../providers/menu_provider.dart';
import '../providers/order_provider.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/order_summary_panel.dart';

class OrderPage extends ConsumerStatefulWidget {
  final String tableId;
  final String tableName;

  const OrderPage({
    super.key,
    required this.tableId,
    required this.tableName,
  });

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(menuProvider.notifier).load();
      ref.read(orderProvider.notifier).initialize(
            tableId: widget.tableId,
            tableName: widget.tableName,
          );
    });
  }

  void _onAddItem(MenuItemEntity item) {
    ref.read(orderProvider.notifier).addItem(item);
  }

  @override
  Widget build(BuildContext context) {
    final menuState = ref.watch(menuProvider);
    final orderState = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.tableName),
            if (orderState.hasItems)
              Text(
                '${orderState.itemCount} ${orderState.itemCount == 1 ? 'producto' : 'productos'}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
              ),
          ],
        ),
      ),
      body: AppResponsive(
        mobile: _MobileLayout(
          menuState: menuState,
          orderState: orderState,
          onAddItem: _onAddItem,
          onCategorySelected: (id) =>
              ref.read(menuProvider.notifier).selectCategory(id),
          onIncrement: (id) =>
              ref.read(orderProvider.notifier).updateQuantity(
                    menuItemId: id,
                    quantity: _getQuantity(orderState, id) + 1,
                  ),
          onDecrement: (id) =>
              ref.read(orderProvider.notifier).updateQuantity(
                    menuItemId: id,
                    quantity: _getQuantity(orderState, id) - 1,
                  ),
          onRemove: (id) =>
              ref.read(orderProvider.notifier).removeItem(id),
          onSend: () => ref.read(orderProvider.notifier).sendOrder(),
        ),
        tablet: _DesktopLayout(
          menuState: menuState,
          orderState: orderState,
          onAddItem: _onAddItem,
          onCategorySelected: (id) =>
              ref.read(menuProvider.notifier).selectCategory(id),
          onIncrement: (id) =>
              ref.read(orderProvider.notifier).updateQuantity(
                    menuItemId: id,
                    quantity: _getQuantity(orderState, id) + 1,
                  ),
          onDecrement: (id) =>
              ref.read(orderProvider.notifier).updateQuantity(
                    menuItemId: id,
                    quantity: _getQuantity(orderState, id) - 1,
                  ),
          onRemove: (id) =>
              ref.read(orderProvider.notifier).removeItem(id),
          onSend: () => ref.read(orderProvider.notifier).sendOrder(),
        ),
        desktop: _DesktopLayout(
          menuState: menuState,
          orderState: orderState,
          onAddItem: _onAddItem,
          onCategorySelected: (id) =>
              ref.read(menuProvider.notifier).selectCategory(id),
          onIncrement: (id) =>
              ref.read(orderProvider.notifier).updateQuantity(
                    menuItemId: id,
                    quantity: _getQuantity(orderState, id) + 1,
                  ),
          onDecrement: (id) =>
              ref.read(orderProvider.notifier).updateQuantity(
                    menuItemId: id,
                    quantity: _getQuantity(orderState, id) - 1,
                  ),
          onRemove: (id) =>
              ref.read(orderProvider.notifier).removeItem(id),
          onSend: () => ref.read(orderProvider.notifier).sendOrder(),
        ),
      ),
    );
  }

  int _getQuantity(OrderState state, String menuItemId) {
    final item = state.items.where((i) => i.menuItem.id == menuItemId);
    return item.isNotEmpty ? item.first.quantity : 0;
  }
}

class _MobileLayout extends StatelessWidget {
  final MenuState menuState;
  final OrderState orderState;
  final void Function(MenuItemEntity) onAddItem;
  final void Function(String?) onCategorySelected;
  final void Function(String) onIncrement;
  final void Function(String) onDecrement;
  final void Function(String) onRemove;
  final VoidCallback onSend;

  const _MobileLayout({
    required this.menuState,
    required this.orderState,
    required this.onAddItem,
    required this.onCategorySelected,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CategoryBar(
          categories: menuState.categories,
          selectedId: menuState.selectedCategoryId,
          onSelected: onCategorySelected,
        ),
        Expanded(
          child: _MenuItemsList(
            items: menuState.filteredItems,
            isLoading: menuState.isLoading,
            orderState: orderState,
            onAddItem: onAddItem,
            isGrid: false,
          ),
        ),
        if (orderState.hasItems)
          _MobileBottomBar(
            total: orderState.total,
            itemCount: orderState.itemCount,
            onTap: () => OrderSummaryPanel.showAsBottomSheet(
              context,
              items: orderState.items,
              total: orderState.total,
              itemCount: orderState.itemCount,
              isSending: orderState.isSending,
              isSent: orderState.isSent,
              hasItems: orderState.hasItems,
              lastOrderId: orderState.lastOrderId,
              onIncrement: onIncrement,
              onDecrement: onDecrement,
              onRemove: onRemove,
              onSend: onSend,
            ),
          ),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final MenuState menuState;
  final OrderState orderState;
  final void Function(MenuItemEntity) onAddItem;
  final void Function(String?) onCategorySelected;
  final void Function(String) onIncrement;
  final void Function(String) onDecrement;
  final void Function(String) onRemove;
  final VoidCallback onSend;

  const _DesktopLayout({
    required this.menuState,
    required this.orderState,
    required this.onAddItem,
    required this.onCategorySelected,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = AppResponsive.isDesktop(context);
    final crossAxisCount = isDesktop ? 3 : 2;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _CategoryBar(
                categories: menuState.categories,
                selectedId: menuState.selectedCategoryId,
                onSelected: onCategorySelected,
              ),
              Expanded(
                child: _MenuItemsList(
                  items: menuState.filteredItems,
                  isLoading: menuState.isLoading,
                  orderState: orderState,
                  onAddItem: onAddItem,
                  isGrid: true,
                  crossAxisCount: crossAxisCount,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          color: Theme.of(context)
              .colorScheme
              .outline
              .withValues(alpha: 0.2),
        ),
        Expanded(
          flex: 2,
          child: OrderSummaryPanel(
            items: orderState.items,
            total: orderState.total,
            itemCount: orderState.itemCount,
            isSending: orderState.isSending,
            isSent: orderState.isSent,
            hasItems: orderState.hasItems,
            lastOrderId: orderState.lastOrderId,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
            onRemove: onRemove,
            onSend: onSend,
          ),
        ),
      ],
    );
  }
}

class _CategoryBar extends StatelessWidget {
  final List<MenuCategoryEntity> categories;
  final String? selectedId;
  final void Function(String?) onSelected;

  const _CategoryBar({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context)
                .colorScheme
                .outline
                .withValues(alpha: 0.15),
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: const Text('Todas'),
                selected: selectedId == null,
                onSelected: (_) => onSelected(null),
              ),
            ),
            ...categories.map((MenuCategoryEntity category) {
              final isSelected = category.id == selectedId;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category.name),
                  selected: isSelected,
                  onSelected: (_) => onSelected(category.id),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _MenuItemsList extends StatelessWidget {
  final List<MenuItemEntity> items;
  final bool isLoading;
  final OrderState orderState;
  final void Function(MenuItemEntity) onAddItem;
  final bool isGrid;
  final int crossAxisCount;

  const _MenuItemsList({
    required this.items,
    required this.isLoading,
    required this.orderState,
    required this.onAddItem,
    required this.isGrid,
    this.crossAxisCount = 2,
  });

  int _getQuantity(MenuItemEntity item) {
    final found = orderState.items.where(
      (i) => i.menuItem.id == item.id,
    );
    return found.isNotEmpty ? found.first.quantity : 0;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(
        child: Text(
          'No hay productos en esta categoría',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5),
              ),
        ),
      );
    }

    if (isGrid) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return MenuItemCard(
            item: item,
            isGrid: true,
            orderQuantity: _getQuantity(item),
            onAdd: () => onAddItem(item),
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
        itemBuilder: (context, index) {
        final item = items[index];
        return MenuItemCard(
          item: item,
          isGrid: false,
          orderQuantity: _getQuantity(item),
          onAdd: () => onAddItem(item),
        );
      },
    );
  }
}

class _MobileBottomBar extends StatelessWidget {
  final double total;
  final int itemCount;
  final VoidCallback onTap;

  const _MobileBottomBar({
    required this.total,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$itemCount ${itemCount == 1 ? 'producto' : 'productos'}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.receipt_long_rounded, size: 18),
              label: const Text('Ver Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
