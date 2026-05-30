import 'package:flutter/material.dart';
import '../../domain/entities/stock_movement_entity.dart';
import '../../domain/enums/movement_type.dart';

class MovementHistoryList extends StatelessWidget {
  final List<StockMovementEntity> movements;

  const MovementHistoryList({super.key, required this.movements});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (movements.isEmpty) {
      return Center(
        child: Text(
          'Sin movimientos registrados',
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: movements.length,
      itemBuilder: (context, index) {
        final mov = movements[index];
        final isEntry = mov.movementType == MovementType.entry;
        final isExit = mov.movementType == MovementType.exit;

        return ListTile(
          dense: true,
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isEntry
                  ? Colors.green.withValues(alpha: 0.1)
                  : isExit
                      ? Colors.red.withValues(alpha: 0.1)
                      : Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isEntry
                  ? Icons.add_circle_outline_rounded
                  : isExit
                      ? Icons.remove_circle_outline_rounded
                      : Icons.tune_rounded,
              size: 18,
              color: isEntry
                  ? Colors.green
                  : isExit
                      ? Colors.red
                      : Colors.blue,
            ),
          ),
          title: Text(
            mov.movementType.displayName,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            '${mov.previousStock.toStringAsFixed(1)} → ${mov.currentStock.toStringAsFixed(1)} | ${mov.note.isNotEmpty ? mov.note : 'Sin observación'}',
            style: TextStyle(
              fontSize: 11,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          trailing: Text(
            '${isEntry ? '+' : isExit ? '-' : ''}${mov.quantity.toStringAsFixed(1)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isEntry
                  ? Colors.green
                  : isExit
                      ? Colors.red
                      : Colors.blue,
            ),
          ),
        );
      },
    );
  }
}
