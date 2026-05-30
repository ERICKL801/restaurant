import 'package:flutter/material.dart';
import '../../domain/entities/menu_category_entity.dart';

class MenuCategoryChip extends StatelessWidget {
  final MenuCategoryEntity category;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuCategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(category.name),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: colorScheme.primaryContainer,
        checkmarkColor: colorScheme.onPrimaryContainer,
        labelStyle: TextStyle(
          color: isSelected
              ? colorScheme.onPrimaryContainer
              : colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
