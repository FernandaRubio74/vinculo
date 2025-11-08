import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/services/api_service.dart'; 
import 'package:vinculo/models/interest_model.dart'; 

final interestsProvider = FutureProvider<List<InterestModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  
  //endpoitn de la api para ver interesesm, de aquí los saco para que se vean en registro
  final response = await apiService.get('/users/interests');

  if (response is List) {
    return response.map((json) => InterestModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  if (response is Map && response['data'] is List) {
    return (response['data'] as List)
        .map((json) => InterestModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  return [];
});