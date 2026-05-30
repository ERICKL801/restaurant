import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/cashier_repository_impl.dart';
import '../../domain/entities/pending_payment_entity.dart';
import '../../domain/repositories/cashier_repository.dart';

final cashierProvider =
    StateNotifierProvider<CashierNotifier, CashierState>((ref) {
  return CashierNotifier(ref.watch(cashierRepositoryProvider));
});

class CashierState {
  final List<PendingPaymentEntity> pendingPayments;
  final bool isLoading;
  final String? error;

  const CashierState({
    this.pendingPayments = const [],
    this.isLoading = false,
    this.error,
  });

  int get totalPending => pendingPayments.length;

  CashierState copyWith({
    List<PendingPaymentEntity>? pendingPayments,
    bool? isLoading,
    String? error,
  }) {
    return CashierState(
      pendingPayments: pendingPayments ?? this.pendingPayments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CashierNotifier extends StateNotifier<CashierState> {
  final CashierRepository _repository;

  CashierNotifier(this._repository) : super(const CashierState());

  Future<void> loadPendingPayments() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payments = await _repository.getPendingPayments();
      state = state.copyWith(
        pendingPayments: payments,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
