// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/user_model.dart';

// Usuarios quemados
final hardcodedUsers = [
  UserModel(
    id: '1',
    email: 'elena@mail.com',
    password: '123456',
    name: 'Elena Ramirez',
    type: UserType.elderly,
    age: 78,
    interests: ['Jardinería', 'Lectura', 'Caminatas'],
  ),
  UserModel(
    id: '2',
    email: 'carlos@mail.com',
    password: '123456',
    name: 'Carlos',
    type: UserType.volunteer,
    age: 25,
    interests: ['Música', 'Deportes', 'Tecnología'],
  ),
];

// Provider del usuario actual
final currentUserProvider = StateProvider<UserModel?>((ref) => null);

// Provider del estado de autenticación
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.unauthenticated);

  Future<LoginResult> login(String email, String password) async {
    state = AuthState.loading;
    
    // Simular delay de red
    await Future.delayed(const Duration(seconds: 1));
    
    // Buscar usuario en los datos quemados
    try {
      final user = hardcodedUsers.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      
      state = AuthState.authenticated;
      return LoginResult.success(user);
    } catch (e) {
      state = AuthState.unauthenticated;
      return LoginResult.failure('Email o contraseña incorrectos');
    }
  }

  void logout() {
    state = AuthState.unauthenticated;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

enum AuthState {
  loading,
  authenticated,
  unauthenticated,
}

class LoginResult {
  final bool isSuccess;
  final String? errorMessage;
  final UserModel? user;

  LoginResult.success(this.user)
      : isSuccess = true,
        errorMessage = null;

  LoginResult.failure(this.errorMessage)
      : isSuccess = false,
        user = null;
}