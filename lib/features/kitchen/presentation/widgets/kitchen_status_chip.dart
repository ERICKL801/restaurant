import 'package:flutter/material.dart';
import '../../domain/enums/kitchen_order_status.dart';

class KitchenStatusChip extends StatelessWidget {
  final KitchenOrderStatus status;

  const KitchenStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: _color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color get _color {
    switch (status) {
      case KitchenOrderStatus.sent:
        return Colors.grey;
      case KitchenOrderStatus.preparing:
        return Colors.orange;
      case KitchenOrderStatus.ready:
        return Colors.green;
      case KitchenOrderStatus.delivered:
        return Colors.blue;
    }
  }
}
