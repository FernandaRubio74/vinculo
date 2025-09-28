import 'package:flutter/material.dart';
import 'package:vinculo/screens/landig_screen.dart';
import 'package:vinculo/screens/login_screen.dart';
import 'package:vinculo/screens/register_screen.dart';
import 'package:vinculo/screens/role_selection_screen.dart';
import 'package:vinculo/screens/elderly/register_elderly_screen.dart';


class AppRoutes {
  static const String landing = '/';
  static const String login = '/login';
  static const String register = '/registro';
  static const String roles = '/roles';
  static const String registerElderly = '/register_elderly';


  static Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingPage(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterGeneralScreen(),
    roles: (context) => const RoleSelectionScreen(),
    registerElderly: (context) => const RegisterElderlyScreen(),
    // Agrega más rutas aquí
  };
}