import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/history_item.dart';
import 'package:vinculo/services/api_service.dart';

class HistoryService {
  final ApiService _api;

  HistoryService(this._api);

  Future<List<HistoryItem>> getUserHistory(String userId) async {
    final data = await _api.get('/history/$userId');
    if (data is List) {
      return data.map((e) => HistoryItem.fromJson(e)).toList();
    }
    return [];
  }
}

final historyServiceProvider = Provider<HistoryService>((ref) {
  final api = ref.read(apiServiceProvider);
  return HistoryService(api);
});
