import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/services/api_service.dart';
import 'package:vinculo/config/providers/auth_provider.dart';

class MatchSuggestionsNotifier extends AsyncNotifier<List<UserModel>> {
  
  @override
  Future<List<UserModel>> build() async {
    final apiService = ref.read(apiServiceProvider);
    final user = ref.read(currentUserProvider);
    if (user == null) return []; 

    final response = await apiService.get('/matching/suggestions/${user.id}');

    //debugs, para ver lo que obtiene
    if (kDebugMode) print('Provider de Sugerencias recibió: ${response.runtimeType}');

    if (response is Map<String, dynamic> && response.containsKey('data')) {
      
      final dataList = response['data'] as List<dynamic>;
      
      // lista de sugerencias
      if (kDebugMode) print('Provider extrajo ${dataList.length} sugerencias.');

      try {
        // Esto parsea la lista de JSONs a UserModels
        return dataList.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
      } catch (e) {
        if (kDebugMode) {
          print('ERROR DE PARSEO: $e');
        }
        return []; // Devuelve vacío para evitar que la app crashee
      }
    }
    
    // este fallback por si el backend devuelve una lista directa
    if (response is List) {
       return response.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
    }

    return [];
  }


  Future<bool> sendConnectionRequest(String targetUserId) async {
    final apiService = ref.read(apiServiceProvider);
    final user = ref.read(currentUserProvider);
    if (user == null) return false;
    try {
      await apiService.post('/matching/request', {
        'fromId': user.id,
        'toId': targetUserId,
      });
      final currentState = state.valueOrNull ?? [];
      final newState = currentState.where((u) => u.id != targetUserId).toList();
      state = AsyncData(newState);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<void> rejectSuggestion(String targetUserId) async {
    final currentState = state.valueOrNull ?? [];
    final newState = currentState.where((u) => u.id != targetUserId).toList();
    state = AsyncData(newState);
  }
}

final matchSuggestionsProvider = AsyncNotifierProvider<MatchSuggestionsNotifier, List<UserModel>>(() {
  return MatchSuggestionsNotifier();
});