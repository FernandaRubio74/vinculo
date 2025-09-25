import 'package:flutter/material.dart';
import 'package:vinculo/screens/landig_screen.dart';
import 'package:vinculo/screens/register_screen.dart';
import 'package:vinculo/utils/constants.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
 return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        primaryColor: AppConstants.primaryColor,
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        fontFamily: 'Inter',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/registro': (context) => const RegistroScreen(), // Tu pantalla de registro anterior
      },
      debugShowCheckedModeBanner: false,
    );
  }
}