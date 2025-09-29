import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/router/app_router.dart';
import 'package:vinculo/utils/constants.dart';

void main() {
  runApp(const ProviderScope(child: MiApp()));
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
      initialRoute: AppRoutes.landing,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
