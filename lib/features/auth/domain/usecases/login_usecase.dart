import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}
