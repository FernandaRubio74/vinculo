import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/models/reward.dart';
import 'package:vinculo/services/api_service.dart';

class RewardsService {
  final ApiService _api;

  RewardsService(this._api);

  Future<List<Reward>> getAllRewards() async {
    final data = await _api.get('/rewards');
    if (data is List) {
      return data.map((e) => Reward.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> redeemReward(String rewardId) async {
    await _api.post('/rewards/redeem', {'rewardId': rewardId});
  }
}

final rewardsServiceProvider = Provider<RewardsService>((ref) {
  final api = ref.read(apiServiceProvider);
  return RewardsService(api);
});
