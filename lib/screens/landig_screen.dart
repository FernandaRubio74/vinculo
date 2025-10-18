import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ← NUEVO IMPORT
import '../utils/constants.dart';
import '../widgets/custom_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreen();
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Stack(
        children: [
          // Elementos de fondo decorativos
          Positioned(
            top: -192,
            left: -192,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.primaryColor.withOpacity(0.3),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.secondaryColor.withOpacity(0.2),
                      blurRadius: 120,
                      spreadRadius: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -192,
            right: -192,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.primaryColor.withOpacity(0.2),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.primaryColor.withOpacity(0.1),
                      blurRadius: 120,
                      spreadRadius: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.largePadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icono
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: AppConstants.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(AppConstants.largePadding),
                              boxShadow: [
                                BoxShadow(
                                  color: AppConstants.secondaryColor.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 48,
                              color: AppConstants.primaryColor,
                            ),
                          ),
                          
                          const SizedBox(height: AppConstants.largePadding),
                          
                          // Título
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textColor,
                                fontFamily: 'Public Sans',
                              ),
                              children: [
                                TextSpan(text: '${AppConstants.welcomeMessage}\nBienvenido a '),
                                TextSpan(
                                  text: AppConstants.appName,
                                  style: const TextStyle(color: AppConstants.primaryColor),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: AppConstants.defaultPadding),
                          
                          // Descripción
                          SizedBox(
                            width: 320,
                            child: Text(
                              'Tu espacio para conectar y compartir momentos con quienes más quieres.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: AppConstants.textColor.withOpacity(0.7),
                                height: 1.5,
                                fontFamily: 'Public Sans',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Botón personalizado
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppConstants.largePadding, 
                    0, 
                    AppConstants.largePadding, 
                    48
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Comenzar',
                      onPressed: () {
                        context.push('/login'); // ← CAMBIO AQUÍ
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}