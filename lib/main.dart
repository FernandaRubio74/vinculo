import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/config/router/go_router_config.dart'; // ← NUEVO IMPORT
import 'package:vinculo/utils/constants.dart';

void main() {
  runApp(const ProviderScope(child: MiApp()));
}

class MiApp extends ConsumerWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeNotifierProvider);
    
    return MaterialApp.router( 
      title: AppConstants.appName,
      theme: appTheme.getTheme(),
      routerConfig: appRouter, 
      debugShowCheckedModeBanner: false,
    );
  }
}