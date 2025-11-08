import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/user_model.dart'; 
import 'package:vinculo/services/api_service.dart';

final registerDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});


final currentUserProvider = StateProvider<UserModel?>((ref) => null);


enum AuthState { loading, authenticated, unauthenticated, }

class LoginResult { 
  final bool isSuccess;
  final String? errorMessage;
  final UserModel? user;
  LoginResult.success(this.user) : isSuccess = true, errorMessage = null;
  LoginResult.failure(this.errorMessage) : isSuccess = false, user = null;
}


class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  AuthNotifier(this.ref) : super(AuthState.unauthenticated);

  ApiService get _apiService => ref.read(apiServiceProvider);

  //loginn
  Future<LoginResult> login(String email, String password) async {
    state = AuthState.loading;
    try {
      // usando el backend, auth service
      final dynamic response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      final responseMap = response as Map<String, dynamic>; 
      // usando token para logearse
      final token = responseMap['token'] as String;
      final userData = responseMap['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(userData);
      
      _apiService.setAuthToken(token);
      ref.read(currentUserProvider.notifier).state = user;
      
      state = AuthState.authenticated;
      return LoginResult.success(user); 
    } catch (e) {
      state = AuthState.unauthenticated;
      final errorMessage = e.toString().contains('Exception:') 
          ? e.toString().replaceFirst('Exception: ', '') 
          : 'Error de conexión o credenciales incorrectas.';
      return LoginResult.failure(errorMessage);
    }
  }

  //registro de adulto mayor
  Future<LoginResult> registerElderly({
    required String email, required String password, required String fullName,
    required String birthDate, required String phone, required String gender,
    required String bio, required String city, required String country,
    required String preferredGender,
    required String mobilityLevel,
    required int techLevel, 
    required List<String> interestIds,
  }) async {
    state = AuthState.loading;
    
    final Map<String, dynamic> data = {
      'fullName': fullName, 'email': email, 'password': password,
      'profilePhotoUrl': '', // DTO de NestJS lo tiene
      'interestIds': interestIds.map((id) => int.parse(id)).toList(), 
      'bio': bio, 'birthDate': birthDate, 'phone': phone, 'gender': gender,
      'city': city, 'country': country, 'techLevel': techLevel,
      'mobilityLevel': mobilityLevel, 'preferredGender': preferredGender,
    };
    
    try {
      final response = await _apiService.post('/auth/register-elderly', data);
      
      final responseMap = response as Map<String, dynamic>;
      final token = responseMap['token'] as String;
      final userData = responseMap['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(userData);

      _apiService.setAuthToken(token);
      ref.read(currentUserProvider.notifier).state = user;
      
      state = AuthState.authenticated;
      return LoginResult.success(user); // Inicia sesión automáticamente
    } catch (e) {
      state = AuthState.unauthenticated;
      return LoginResult.failure(e.toString().replaceFirst('Exception: ', '')); 
    }
  }

  // registro de voluntario
  Future<LoginResult> registerVolunteer({
    required String email, required String password, required String fullName,
    required String birthDate, required String phone, required String gender,
    required String bio, required String city, required String country,
    required String preferredGender,
    required List<String> skills,
    required Map<String, List<String>> availability,
    required bool hasVolunteerExperience,
    required List<String> interestIds,
  }) async {
    state = AuthState.loading;
    
    final Map<String, dynamic> data = {
      'fullName': fullName, 'email': email, 'password': password,
      'profilePhotoUrl': '', // DTO de NestJS lo tiene
      'interestIds': interestIds.map((id) => int.parse(id)).toList(),
      'bio': bio, 'birthDate': birthDate, 'phone': phone, 'gender': gender,
      'city': city, 'country': country, 'skills': skills,
      'availability': availability, 'hasVolunteerExperience': hasVolunteerExperience,
      'preferredGender': preferredGender,
    };
    
    try {
      final response = await _apiService.post('/auth/register-volunteer', data);
      
      final responseMap = response as Map<String, dynamic>;
      final token = responseMap['token'] as String;
      final userData = responseMap['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(userData);

      _apiService.setAuthToken(token);
      ref.read(currentUserProvider.notifier).state = user;
      
      state = AuthState.authenticated;
      return LoginResult.success(user); // Inicia sesión automáticamente
    } catch (e) {
      state = AuthState.unauthenticated;
      return LoginResult.failure(e.toString().replaceFirst('Exception: ', '')); 
    }
  }

  void logout() {
    ref.read(currentUserProvider.notifier).state = null;
    _apiService.setAuthToken(null);
    state = AuthState.unauthenticated;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});