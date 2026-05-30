import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../domain/enums/movement_type.dart';
import '../providers/inventory_detail_provider.dart';
import '../widgets/inventory_detail_view.dart';
import '../widgets/movement_form_dialog.dart';

class InventoryDetailPage extends ConsumerStatefulWidget {
  final String itemId;

  const InventoryDetailPage({super.key, required this.itemId});

  @override
  ConsumerState<InventoryDetailPage> createState() =>
      _InventoryDetailPageState();
}

class _InventoryDetailPageState extends ConsumerState<InventoryDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(inventoryDetailProvider.notifier).loadItem(widget.itemId);
    });
  }

  Future<void> _showMovementDialog(String itemName, String unit) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => MovementFormDialog(itemName: itemName, unit: unit),
    );

    if (result != null) {
      await ref.read(inventoryDetailProvider.notifier).registerMovement(
            itemId: widget.itemId,
            type: result['type'] as MovementType,
            quantity: result['quantity'] as double,
            note: result['note'] as String,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.item?.name ?? 'Detalle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Volver',
            onPressed: () => context.go(RoutePaths.inventory),
          ),
        ],
      ),
      body: InventoryDetailView(
        state: state,
        onAddMovement: () {
          if (state.item != null) {
            _showMovementDialog(state.item!.name, state.item!.unit);
          }
        },
      ),
    );
  }
}
