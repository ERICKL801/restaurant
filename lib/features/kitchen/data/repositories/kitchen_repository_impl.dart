import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/kitchen_order_entity.dart';
import '../../domain/enums/kitchen_order_status.dart';
import '../../domain/repositories/kitchen_repository.dart';
import '../datasources/kitchen_datasource.dart';
import '../datasources/mock_kitchen_datasource.dart';

final kitchenRepositoryProvider = Provider<KitchenRepository>((ref) {
  return KitchenRepositoryImpl(ref.watch(mockKitchenDatasourceProvider));
});

class KitchenRepositoryImpl implements KitchenRepository {
  final KitchenDatasource _datasource;

  KitchenRepositoryImpl(this._datasource);

  @override
  Future<List<KitchenOrderEntity>> getOrders() => _datasource.getOrders();

  @override
  Future<void> updateOrderStatus(
    String orderId,
    KitchenOrderStatus status,
  ) => _datasource.updateOrderStatus(orderId, status);
}
