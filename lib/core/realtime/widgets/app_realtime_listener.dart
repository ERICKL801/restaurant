import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/realtime_providers.dart';

class AppRealtimeListener extends ConsumerWidget {
  final Widget child;

  const AppRealtimeListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(orderSentEventProvider, (prev, next) {
      final event = next.valueOrNull;
      if (event == null) return;
      _showNotification(
        context,
        title: 'Pedido enviado',
        message: 'Mesa ${event.tableName} — ${event.itemCount} item(s)',
        color: Theme.of(context).colorScheme.primary,
      );
    });

    ref.listen(orderPreparingEventProvider, (prev, next) {
      final event = next.valueOrNull;
      if (event == null) return;
      _showNotification(
        context,
        title: 'Pedido en preparación',
        message: '${event.tableName} — Cocina',
        color: Colors.orange,
      );
    });

    ref.listen(orderReadyEventProvider, (prev, next) {
      final event = next.valueOrNull;
      if (event == null) return;
      _showNotification(
        context,
        title: 'Pedido listo',
        message: '${event.tableName} — Listo para entregar',
        color: Colors.green,
      );
    });

    ref.listen(orderDeliveredEventProvider, (prev, next) {
      final event = next.valueOrNull;
      if (event == null) return;
      _showNotification(
        context,
        title: 'Pedido entregado',
        message: '${event.tableName} — Pendiente de cobro',
        color: Theme.of(context).colorScheme.tertiary,
      );
    });

    ref.listen(paymentCompletedEventProvider, (prev, next) {
      final event = next.valueOrNull;
      if (event == null) return;
      _showNotification(
        context,
        title: 'Pago registrado',
        message:
            '${event.tableName} — S/ ${event.amount.toStringAsFixed(2)} (${event.paymentMethod})',
        color: Colors.green,
      );
    });

    ref.listen(inventoryUpdatedEventProvider, (prev, next) {
      final event = next.valueOrNull;
      if (event == null) return;
      _showNotification(
        context,
        title: 'Stock actualizado',
        message:
            '${event.itemName} — ${event.newStock.toStringAsFixed(0)} (${event.movementType})',
        color: Colors.blueGrey,
      );
    });

    return child;
  }

  void _showNotification(
    BuildContext context, {
    required String title,
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
