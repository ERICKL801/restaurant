import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
  });

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userModel = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    await _localDataSource.cacheUser(userModel);
    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
    await _localDataSource.clearCache();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await _localDataSource.getLastUser();
    return user?.toEntity();
  }
}
