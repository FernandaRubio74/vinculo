import 'package:flutter/material.dart';


const Map<String, IconData> interestIcons = {
  'Jardinería': Icons.eco,
  'Lectura': Icons.book,
  'Caminatas': Icons.directions_walk,
  'Música': Icons.music_note,
  'Deportes': Icons.sports_soccer,
  'Tecnología': Icons.computer,
  'Cocina': Icons.restaurant_menu,
  'Arte': Icons.brush,
  'Películas': Icons.movie,
  'Viajes': Icons.flight,
  'Historia': Icons.history_edu,
};

class InterestModel {
  final String id; 
  final String name;
  final IconData icon;

  InterestModel({required this.id, required this.name, required this.icon});

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final icon = interestIcons[name] ?? Icons.widgets; 
    
    return InterestModel(
      id: json['id'].toString(), 
      name: name,
      icon: icon,
    );
  }
}