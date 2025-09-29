import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppConstants {
  // Colores
  static const Color primaryColor = Color(0xFF13a4ec);
  static const Color secondaryColor = Color(0xFF003049);
  static const Color accentColor = Color(0xFF780000);
  static const Color accentColorLight = Color(0xFFC1121F);
  static const Color backgroundColor = Colors.white;
  static const Color backgroundDark = Color(0xFF101c22);
  static const Color textColor = Colors.black87;
  static const Color hintColor = Color.fromARGB(255, 189, 215, 230);
  
  // Espaciado
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  // Bordes
  static const double borderRadius = 8.0;
  
  // Textos
  static const String appName = 'Vínculo Vital';
  static const String loginTitle = 'Iniciar Sesión';
  static const String welcomeMessage = '¡Bienvenid@!';

  // Fuentes
  static TextStyle headingStyle = GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
}