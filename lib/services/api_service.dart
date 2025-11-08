import 'dart:convert';
import 'package:flutter/foundation.dart'; 
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiService {
  // (10.0.2.2 para Android Emulator)
  static const String _baseUrl = 'http://localhost:3000'; 
  String? _authToken;

  void setAuthToken(String? token) {
    _authToken = token;
  }
  
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_authToken != null) 'Authorization': 'Bearer $_authToken',
  };


  Future<dynamic> post(String path, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl$path');

    if (kDebugMode) {
      print('[POST] Enviando a: $path');
    }

    final response = await http.post(
      url,
      headers: _headers,
      body: json.encode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (kDebugMode) print('[POST] Éxito: $path');
      if (response.body.isEmpty) return {}; 
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print('[POST] ERROR (StatusCode: ${response.statusCode}) en $path');
        print('[POST] CUERPO DEL ERROR: ${response.body}');
      }
      throw Exception('Error en POST: ${response.body}');
    }
  }

  Future<dynamic> get(String path) async {
    final url = Uri.parse('$_baseUrl$path');
    
    if (kDebugMode) print('[GET] Pidiendo a: $path');
    
    final response = await http.get(url, headers: _headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (kDebugMode) print('[GET] Respuesta OK de $path');
      if (response.body.isEmpty) return {}; 
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print('[GET] ERROR (StatusCode: ${response.statusCode}) en $path');
        print('[GET] CUERPO DEL ERROR: ${response.body}');
      }
      throw Exception('Error en GET: ${response.body}');
    }
  }
  
  Future<dynamic> put(String path, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl$path');
    
    if (kDebugMode) print('[PUT] Enviando a: $path');

    final response = await http.put(
      url,
      headers: _headers,
      body: json.encode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (kDebugMode) print('[PUT] Éxito: $path');
      if (response.body.isEmpty) return {};
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print('[PUT] ERROR (StatusCode: ${response.statusCode}) en $path');
        print('[PUT] CUERPO DEL ERROR: ${response.body}');
      }
      throw Exception('Error en PUT: ${response.body}');
    }
  }
}

final apiServiceProvider = Provider((ref) => ApiService());