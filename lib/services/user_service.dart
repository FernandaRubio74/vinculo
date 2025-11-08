import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/services/api_service.dart';

class UserService {
  final ApiService _api;

  UserService(this._api);

  Future<UserModel> getProfile(String userId) async {
    final data = await _api.get('/users/$userId');
    return UserModel.fromJson(data);
  }

  Future<UserModel> updateProfile(String userId, Map<String, dynamic> updates) async {
    final data = await _api.put('/users/$userId', updates);
    return UserModel.fromJson(data);
  }
}

final userServiceProvider = Provider<UserService>((ref) {
  final api = ref.read(apiServiceProvider);
  return UserService(api);
});
