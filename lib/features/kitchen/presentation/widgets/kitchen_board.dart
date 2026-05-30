import 'package:flutter/material.dart';
import '../../domain/enums/kitchen_order_status.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../providers/kitchen_provider.dart';
import 'kitchen_column.dart';

class KitchenBoard extends StatelessWidget {
  final KitchenState state;
  final void Function(String orderId) onAdvance;

  const KitchenBoard({
    super.key,
    required this.state,
    required this.onAdvance,
  });

  @override
  Widget build(BuildContext context) {
    return AppResponsive(
      mobile: _buildMobileLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: _buildColumn(context, KitchenOrderStatus.sent),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: _buildColumn(context, KitchenOrderStatus.preparing),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: _buildColumn(context, KitchenOrderStatus.ready),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: _buildColumn(context, KitchenOrderStatus.delivered),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildColumn(context, KitchenOrderStatus.sent),
                ),
                Expanded(
                  child: _buildColumn(context, KitchenOrderStatus.preparing),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildColumn(context, KitchenOrderStatus.ready),
                ),
                Expanded(
                  child: _buildColumn(context, KitchenOrderStatus.delivered),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(child: _buildColumn(context, KitchenOrderStatus.sent)),
          const SizedBox(width: 8),
          Expanded(child: _buildColumn(context, KitchenOrderStatus.preparing)),
          const SizedBox(width: 8),
          Expanded(child: _buildColumn(context, KitchenOrderStatus.ready)),
          const SizedBox(width: 8),
          Expanded(child: _buildColumn(context, KitchenOrderStatus.delivered)),
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context, KitchenOrderStatus status) {
    final config = _columnConfig(status);
    return KitchenColumn(
      title: config.label,
      status: status,
      color: config.color,
      orders: state.ordersByStatus(status),
      onAdvance: onAdvance,
    );
  }

  _ColumnConfig _columnConfig(KitchenOrderStatus status) {
    switch (status) {
      case KitchenOrderStatus.sent:
        return const _ColumnConfig('Pendientes', Colors.grey);
      case KitchenOrderStatus.preparing:
        return const _ColumnConfig('Preparando', Colors.orange);
      case KitchenOrderStatus.ready:
        return const _ColumnConfig('Listos', Colors.green);
      case KitchenOrderStatus.delivered:
        return const _ColumnConfig('Entregados', Colors.blue);
    }
  }
}

class _ColumnConfig {
  final String label;
  final Color color;
  const _ColumnConfig(this.label, this.color);
}
