import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../shared/providers/core_providers.dart';
import '../models/user_model.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(dioProvider));
});

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // TODO: Remove mock cuando el backend esté disponible
    if (email == 'admin@restotab.com' && password == '123456') {
      return UserModel(
        id: '1',
        email: email,
        name: 'Admin',
        role: 'admin',
        token: 'mock-token-123',
      );
    }
    if (email == 'mesero@restotab.com' && password == '123456') {
      return UserModel(
        id: '2',
        email: email,
        name: 'Mesero',
        role: 'waiter',
        token: 'mock-token-456',
      );
    }

    final response = await _dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> logout() async {
    await _dio.post(ApiConstants.logout);
  }

  Future<UserModel> getProfile() async {
    final response = await _dio.get(ApiConstants.profile);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
