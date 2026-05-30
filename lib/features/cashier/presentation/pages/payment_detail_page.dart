import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../providers/payment_detail_provider.dart';
import '../widgets/payment_detail_view.dart';

class PaymentDetailPage extends ConsumerStatefulWidget {
  final String orderId;
  final String tableId;
  final String tableName;

  const PaymentDetailPage({
    super.key,
    required this.orderId,
    required this.tableId,
    required this.tableName,
  });

  @override
  ConsumerState<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends ConsumerState<PaymentDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(paymentDetailProvider.notifier).initialize(
            orderId: widget.orderId,
            tableId: widget.tableId,
            tableName: widget.tableName,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paymentDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tableName),
        actions: [
          if (state.isCompleted)
            IconButton(
              icon: const Icon(Icons.check_rounded),
              tooltip: 'Volver',
              onPressed: () {
                ref.read(paymentDetailProvider.notifier).reset();
                context.go(RoutePaths.cashier);
              },
            ),
        ],
      ),
      body: PaymentDetailView(
        state: state,
        onSelectMethod: (method) =>
            ref.read(paymentDetailProvider.notifier).selectMethod(method),
        onProcessPayment: () =>
            ref.read(paymentDetailProvider.notifier).processPayment(),
        onReset: () {
          ref.read(paymentDetailProvider.notifier).reset();
          context.go(RoutePaths.cashier);
        },
      ),
    );
  }
}
