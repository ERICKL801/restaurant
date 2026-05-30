import 'package:flutter/material.dart';

class InventorySearchBar extends StatelessWidget {
  final String query;
  final void Function(String) onChanged;

  const InventorySearchBar({
    super.key,
    required this.query,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: TextEditingController(text: query)
          ..selection = TextSelection.collapsed(offset: query.length),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Buscar insumo...',
          prefixIcon: const Icon(Icons.search_rounded, size: 20),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, size: 18),
                  onPressed: () => onChanged(''),
                )
              : null,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
