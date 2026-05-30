import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../domain/entities/pending_payment_entity.dart';
import '../providers/cashier_provider.dart';
import '../providers/payment_detail_provider.dart';
import '../widgets/pending_tables_list.dart';
import '../widgets/payment_detail_view.dart';

class CashierPage extends ConsumerStatefulWidget {
  const CashierPage({super.key});

  @override
  ConsumerState<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends ConsumerState<CashierPage> {
  String? _selectedOrderId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(cashierProvider.notifier).loadPendingPayments();
    });
  }

  void _onSelectPayment(PendingPaymentEntity payment) {
    final isDesktop =
        MediaQuery.of(context).size.width >= 1024;

    if (isDesktop) {
      setState(() => _selectedOrderId = payment.orderId);
      ref.read(paymentDetailProvider.notifier).initialize(
            orderId: payment.orderId,
            tableId: payment.tableId,
            tableName: payment.tableName,
          );
    } else {
      context.go(
        RoutePaths.payment.replaceAll(':orderId', payment.orderId),
        extra: {
          'tableId': payment.tableId,
          'tableName': payment.tableName,
          'total': payment.total.toString(),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cashierProvider);
    final detailState = ref.watch(paymentDetailProvider);
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Caja'),
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
            onPressed: () =>
                ref.read(cashierProvider.notifier).loadPendingPayments(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Volver',
            onPressed: () => context.go(RoutePaths.dashboard),
          ),
        ],
      ),
      body: isDesktop ? _buildDesktopLayout(state, detailState, theme)
          : _buildMobileLayout(state, detailState, theme),
    );
  }

  Widget _buildMobileLayout(
    CashierState state,
    PaymentDetailState detailState,
    ThemeData theme,
  ) {
    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text('Error al cargar cuentas',
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(state.error!, style: theme.textTheme.bodySmall),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () =>
                  ref.read(cashierProvider.notifier).loadPendingPayments(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    return PendingTablesList(
      pendingPayments: state.pendingPayments,
      onTap: _onSelectPayment,
    );
  }

  Widget _buildDesktopLayout(
    CashierState state,
    PaymentDetailState detailState,
    ThemeData theme,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 380,
          child: state.error != null
              ? Center(child: Text('Error: ${state.error!}'))
              : PendingTablesList(
                  pendingPayments: state.pendingPayments,
                  onTap: _onSelectPayment,
                  selectedOrderId: _selectedOrderId,
                ),
        ),
        Container(
          width: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        Expanded(
          child: _selectedOrderId == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payments_rounded,
                        size: 64,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Seleccione una cuenta',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                )
              : PaymentDetailView(
                  state: detailState,
                  onSelectMethod: (method) =>
                      ref.read(paymentDetailProvider.notifier).selectMethod(method),
                  onProcessPayment: () =>
                      ref.read(paymentDetailProvider.notifier).processPayment(),
                  onReset: () {
                    setState(() => _selectedOrderId = null);
                    ref.read(paymentDetailProvider.notifier).reset();
                  },
                ),
        ),
      ],
    );
  }
}


