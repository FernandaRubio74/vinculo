import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/message_model.dart';
import 'package:vinculo/services/api_service.dart';
import 'package:vinculo/config/providers/auth_provider.dart';
import 'dart:async';

// Provider para los mensajes de una conversación
class ChatNotifier extends AsyncNotifier<List<MessageModel>> {
  String? _connectionId;
  Timer? _pollingTimer;

  @override
  Future<List<MessageModel>> build() async {
    return [];
  }

  // Inicializar chat con una conexión
  Future<void> initChat(String connectionId) async {
    _connectionId = connectionId;
    await loadMessages();
    _startPolling();
  }

  // Cargar mensajes iniciales
  Future<void> loadMessages() async {
    if (_connectionId == null) return;

    state = const AsyncValue.loading();

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getMessages(
        connectionId: _connectionId!,
        page: 1,
        limit: 50,
      );

      final messagesList = response['messages'] as List<dynamic>;
      final messages = messagesList
          .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();

      state = AsyncValue.data(messages);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Enviar mensaje
  Future<void> sendMessage(String receiverId, String content) async {
    if (_connectionId == null) return;
    if (content.trim().isEmpty) return;

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.sendMessage(
        receiverId: receiverId,
        connectionId: _connectionId!,
        content: content,
      );

      final newMessage = MessageModel.fromJson(response as Map<String, dynamic>);

      // Agregar mensaje a la lista local
      final currentMessages = state.valueOrNull ?? [];
      state = AsyncValue.data([...currentMessages, newMessage]);
    } catch (e) {
      if (kDebugMode) {
        print('Error al enviar mensaje: $e');
      }
      rethrow;
    }
  }

  // Polling para nuevos mensajes (cada 3 segundos)
  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _checkNewMessages();
    });
  }

  Future<void> _checkNewMessages() async {
    if (_connectionId == null) return;

    try {
      final apiService = ref.read(apiServiceProvider);
      final currentMessages = state.valueOrNull ?? [];
      
      final lastMessageId = currentMessages.isNotEmpty ? currentMessages.last.id : null;

      final response = await apiService.getNewMessages(
        connectionId: _connectionId!,
        lastMessageId: lastMessageId,
      );

      if (response is List && response.isNotEmpty) {
        final newMessages = response
            .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
            .toList();

        state = AsyncValue.data([...currentMessages, ...newMessages]);

        // Marcar como leídos
        await apiService.markAsRead(_connectionId!);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error en polling: $e');
      }
    }
  }

  // Marcar mensajes como leídos
  Future<void> markAsRead() async {
    if (_connectionId == null) return;

    try {
      final apiService = ref.read(apiServiceProvider);
      await apiService.markAsRead(_connectionId!);
    } catch (e) {
      if (kDebugMode) {
        print('Error al marcar como leído: $e');
      }
    }
  }

  // Limpiar al salir del chat
  void dispose() {
    _pollingTimer?.cancel();
    _connectionId = null;
  }
}

final chatProvider = AsyncNotifierProvider<ChatNotifier, List<MessageModel>>(() {
  return ChatNotifier();
});

// Provider para contar mensajes no leídos
final unreadCountProvider = FutureProvider.family<int, String?>((ref, connectionId) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.getUnreadCount(connectionId: connectionId);
  return response['count'] as int;
});