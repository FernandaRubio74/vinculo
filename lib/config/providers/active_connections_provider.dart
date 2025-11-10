import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/services/api_service.dart';
import 'package:vinculo/config/providers/auth_provider.dart';

/// Clase para envolver usuario con su connectionId
class ConnectionWithId {
  final UserModel user;
  final String connectionId;

  ConnectionWithId({
    required this.user,
    required this.connectionId,
  });
}

/// Provider para las conexiones "amigos"
final activeConnectionsProvider = FutureProvider<List<ConnectionWithId>>((ref) async {
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

  final List<ConnectionWithId> connections = [];
  
  for (var connectionJson in response) {
    try {
      // Extraer el connectionId
      final connectionId = connectionJson['id'] as String;
      
      final elderUser = UserModel.fromJson(connectionJson['elder'] as Map<String, dynamic>);
      final youngUser = UserModel.fromJson(connectionJson['young'] as Map<String, dynamic>);

      // Agregar el usuario opuesto con su connectionId
      if (elderUser.id == currentUserId) {
        connections.add(ConnectionWithId(
          user: youngUser,
          connectionId: connectionId,
        ));
      } else if (youngUser.id == currentUserId) {
        connections.add(ConnectionWithId(
          user: elderUser,
          connectionId: connectionId,
        ));
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