import 'package:flutter/material.dart';
import '../../domain/enums/stock_status.dart';

class StockStatusChip extends StatelessWidget {
  final StockStatus status;

  const StockStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: _color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color get _color {
    switch (status) {
      case StockStatus.normal:
        return Colors.green;
      case StockStatus.low:
        return Colors.orange;
      case StockStatus.critical:
        return Colors.red;
    }
  }
}
