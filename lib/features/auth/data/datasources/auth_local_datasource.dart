import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource();
});

class AuthLocalDataSource {
  UserModel? _cachedUser;

  Future<void> cacheUser(UserModel user) async {
    _cachedUser = user;
  }

  Future<UserModel?> getLastUser() async {
    return _cachedUser;
  }

  Future<void> clearCache() async {
    _cachedUser = null;
  }
}
