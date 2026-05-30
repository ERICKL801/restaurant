import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.min = 0,
    this.max = 99,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Button(
          icon: Icons.remove_rounded,
          onTap: quantity > min ? () => onChanged(quantity - 1) : null,
        ),
        SizedBox(
          width: 40,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        _Button(
          icon: Icons.add_rounded,
          onTap: quantity < max ? () => onChanged(quantity + 1) : null,
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _Button({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(
              color: onTap != null
                  ? Theme.of(context).colorScheme.outline
                  : Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 16,
            color: onTap != null
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
