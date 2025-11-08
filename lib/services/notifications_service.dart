import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/notification_item.dart';
import 'package:vinculo/services/api_service.dart';

class NotificationsService {
  final ApiService _api;

  NotificationsService(this._api);

  Future<List<NotificationItem>> getNotifications(String userId) async {
    final data = await _api.get('/notifications/$userId');
    if (data is List) {
      return data.map((e) => NotificationItem.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> markAsRead(String notificationId) async {
    await _api.put('/notifications/$notificationId', {'read': true});
  }
}

final notificationsServiceProvider = Provider<NotificationsService>((ref) {
  final api = ref.read(apiServiceProvider);
  return NotificationsService(api);
});
