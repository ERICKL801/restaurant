import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';
import '../../data/repositories/order_repository_impl.dart';

final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
  return CreateOrderUseCase(ref.watch(orderRepositoryProvider));
});

class CreateOrderUseCase {
  final OrderRepository _repository;

  CreateOrderUseCase(this._repository);

  Future<OrderEntity> call(OrderEntity order) {
    return _repository.createOrder(order);
  }
}
