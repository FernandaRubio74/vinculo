import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/services/api_service.dart';
import 'package:vinculo/config/providers/auth_provider.dart';
import 'package:vinculo/config/providers/active_connections_provider.dart';


class PendingConnection {
  final String connectionId;
  final UserModel user; //  perfil de quien envia la solicitud

  PendingConnection({required this.connectionId, required this.user});
}

class PendingConnectionsNotifier extends AsyncNotifier<List<PendingConnection>> {
  
  @override
  Future<List<PendingConnection>> build() async {
    final apiService = ref.read(apiServiceProvider);
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return [];

    // desde back /connections/pending
    final response = await apiService.get('/connections/pending');

    List<dynamic> dataList;
    
    
    if (response is Map<String, dynamic> && response.containsKey('data')) {
      dataList = response['data'] as List<dynamic>;
    } else if (response is List) {
      dataList = response;
    } else {
      return [];
    }

    final List<PendingConnection> pendingList = [];
    
    for (var connectionJson in dataList) {
      try {
        final elderUser = UserModel.fromJson(connectionJson['elder'] as Map<String, dynamic>);
        final youngUser = UserModel.fromJson(connectionJson['young'] as Map<String, dynamic>);
        
        UserModel requester;
        final String initiatedBy = connectionJson['initiatedBy'];
        
        if (initiatedBy == currentUser.id) continue;
        
        if (initiatedBy == elderUser.id) {
          requester = elderUser;
        } else {
          requester = youngUser;
        }

        pendingList.add(PendingConnection(
          connectionId: connectionJson['id'] as String,
          user: requester,
        ));
        
      } catch (e) {
        if (kDebugMode) print('Error al parsear solicitud pendiente: $e');
      }
    }
    return pendingList;
  }

 
  Future<void> acceptRequest(String connectionId) async {
    final apiService = ref.read(apiServiceProvider);
    
    try {
      await apiService.put('/matching/accept/$connectionId', {});

     
      ref.invalidate(pendingConnectionsProvider); 
      ref.invalidate(activeConnectionsProvider);
      
    } catch (e) {
      if (kDebugMode) print('Error al aceptar la conexión: $e');
    }
  }

 //rechazar
  Future<void> rejectRequest(String connectionId) async {
    final apiService = ref.read(apiServiceProvider);
    
    try {
      await apiService.put('/matching/reject/$connectionId', {});

      ref.invalidate(pendingConnectionsProvider);
      
    } catch (e) {
      if (kDebugMode) print('Error al rechazar la conexión: $e');
    }
  }
}


final pendingConnectionsProvider = AsyncNotifierProvider<PendingConnectionsNotifier, List<PendingConnection>>(() {
  return PendingConnectionsNotifier();
});