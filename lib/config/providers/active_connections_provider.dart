import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/services/api_service.dart';
import 'package:vinculo/config/providers/auth_provider.dart';

/// provider para las conexiones "amigos"
final activeConnectionsProvider = FutureProvider<List<UserModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final currentUser = ref.watch(currentUserProvider); // 'watch' reacciona al login

  if (currentUser == null) {
    return []; // No logueado, no hay conexiones
  }
  final currentUserId = currentUser.id;

  // /connections/active
  final response = await apiService.get('/connections/active');

  if (response is! List) {
    if (kDebugMode) {
      print('[activeConnectionsProvider] Error: La respuesta no es una Lista.');
    }
    return []; 
  }


  final List<UserModel> connections = [];
  
  for (var connectionJson in response) {
    try {

      final elderUser = UserModel.fromJson(connectionJson['elder'] as Map<String, dynamic>);
      final youngUser = UserModel.fromJson(connectionJson['young'] as Map<String, dynamic>);

      
      if (elderUser.id == currentUserId) {
        connections.add(youngUser);
      } else if (youngUser.id == currentUserId) {
        connections.add(elderUser);
      }
      
    } catch (e) {
      if (kDebugMode) {
        print('[activeConnectionsProvider] Error al parsear conexión: $e. JSON: $connectionJson');
      }
    }
  }
  
  if (kDebugMode) {
    print('[activeConnectionsProvider] Conexiones cargadas: ${connections.length}');
  }
  return connections;
});