import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/kitchen_timer_provider.dart';

class OrderTimer extends ConsumerWidget {
  final DateTime createdAt;

  const OrderTimer({super.key, required this.createdAt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(kitchenTimerProvider);
    final elapsed = DateTime.now().difference(createdAt);
    final minutes = elapsed.inMinutes;
    final seconds = elapsed.inSeconds.remainder(60);

    final color = minutes >= 15
        ? Colors.red
        : minutes >= 8
            ? Colors.orange
            : Colors.grey;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.schedule_rounded, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          minutes > 0
              ? '$minutes min ${seconds}s'
              : '${seconds}s',
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
