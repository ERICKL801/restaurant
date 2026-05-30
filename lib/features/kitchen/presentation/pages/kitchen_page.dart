import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../providers/kitchen_provider.dart';
import '../widgets/kitchen_board.dart';

class KitchenPage extends ConsumerStatefulWidget {
  const KitchenPage({super.key});

  @override
  ConsumerState<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends ConsumerState<KitchenPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(kitchenProvider.notifier).startPolling();
    });
  }

  @override
  void dispose() {
    ref.read(kitchenProvider.notifier).stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(kitchenProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocina'),
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
            onPressed: () => ref.read(kitchenProvider.notifier).loadOrders(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Volver',
            onPressed: () => context.go(RoutePaths.dashboard),
          ),
        ],
      ),
      body: state.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded,
                      size: 48, color: Theme.of(context).colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar pedidos',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.error!,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () =>
                        ref.read(kitchenProvider.notifier).loadOrders(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : state.orders.isEmpty && !state.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.kitchen_rounded,
                        size: 64,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No hay pedidos en cocina',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.5),
                            ),
                      ),
                    ],
                  ),
                )
              : KitchenBoard(
                  state: state,
                  onAdvance: (orderId) =>
                      ref.read(kitchenProvider.notifier).advanceOrder(orderId),
                ),
    );
  }
}
