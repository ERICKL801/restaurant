import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/table_entity.dart';
import '../../domain/enums/table_status.dart';

extension _TableStatusX on TableStatus {
  Color get color {
    switch (this) {
      case TableStatus.available:
        return AppColors.success;
      case TableStatus.occupied:
        return AppColors.error;
      case TableStatus.waitingPayment:
        return AppColors.warning;
      case TableStatus.reserved:
        return AppColors.info;
    }
  }

  Color get background {
    switch (this) {
      case TableStatus.available:
        return AppColors.success.withValues(alpha: 0.1);
      case TableStatus.occupied:
        return AppColors.error.withValues(alpha: 0.1);
      case TableStatus.waitingPayment:
        return AppColors.warning.withValues(alpha: 0.1);
      case TableStatus.reserved:
        return AppColors.info.withValues(alpha: 0.1);
    }
  }

  String get label {
    switch (this) {
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

class TableCard extends StatelessWidget {
  final TableEntity table;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const TableCard({
    super.key,
    required this.table,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = table.status.color;
    final statusBg = table.status.background;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: statusColor.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.table_restaurant_rounded,
                  color: statusColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                table.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 14,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${table.capacity}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  table.status.label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
