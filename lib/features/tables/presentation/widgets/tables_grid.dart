import 'package:flutter/material.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../../domain/entities/table_entity.dart';
import 'table_card.dart';

class TablesGrid extends StatelessWidget {
  final List<TableEntity> tables;
  final void Function(TableEntity table)? onTableTap;
  final void Function(TableEntity table)? onTableLongPress;

  const TablesGrid({
    super.key,
    required this.tables,
    this.onTableTap,
    this.onTableLongPress,
  });

  @override
  Widget build(BuildContext context) {
    if (tables.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.table_restaurant_outlined,
              size: 64,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay mesas disponibles',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5),
                  ),
            ),
          ],
        ),
      );
    }

    return AppResponsive(
      mobile: _buildGrid(context, tables, 2),
      tablet: _buildGrid(context, tables, 3),
      desktop: _buildGrid(context, tables, 5),
    );
  }

  Widget _buildGrid(
    BuildContext context,
    List<TableEntity> tables,
    int crossAxisCount,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.82,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: tables.length,
      itemBuilder: (context, index) {
        final table = tables[index];
        return TableCard(
          table: table,
          onTap: onTableTap != null ? () => onTableTap!(table) : null,
          onLongPress: onTableLongPress != null
              ? () => onTableLongPress!(table)
              : null,
        );
      },
    );
  }
}
