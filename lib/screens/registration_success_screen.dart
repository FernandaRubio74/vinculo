import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  final String userType; // 'volunteer' o 'elderly'
  
  const RegistrationSuccessScreen({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppConstants.textColor,
          ),
        ),
        title: const Text(
          'VínculoVital',
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Public Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.largePadding),
        child: Column(
          children: [
            // Contenido principal
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono de éxito
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppConstants.primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Título
                  const Text(
                    '¡Registro exitoso!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textColor,
                      fontFamily: 'Public Sans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Descripción
                  Container(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Text(
                      _getSuccessMessage(),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConstants.textColor.withOpacity(0.7),
                        height: 1.5,
                        fontFamily: 'Public Sans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            
            // Botón "Ir al Inicio"
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _goToHome(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: AppConstants.primaryColor.withOpacity(0.3),
                ),
                child: const Text(
                  'Ir al Inicio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Public Sans',
                  ),
                ),
              ),
            ),
            
            // Espacio inferior para el safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
          ],
        ),
      ),
    );
  }

  String _getSuccessMessage() {
    if (userType == 'volunteer') {
      return 'Tu cuenta ha sido creada con éxito. Ahora puedes comenzar a explorar y conectar con personas mayores.';
    } else {
      return 'Tu cuenta ha sido creada con éxito. Ahora puedes comenzar a explorar y conectar con jóvenes voluntarios.';
    }
  }

  void _goToHome(BuildContext context) {
    // Navegar al inicio según el tipo de usuario y limpiar el stack de navegación
    if (userType == 'volunteer') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/volunteer_home',
        (route) => false,
      );
    } else {
      // Para adultos mayores, navegamos a su pantalla de inicio (cuando la crees)
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/elderly_home', // Deberás crear esta ruta más adelante
        (route) => false,
      );
    }
  }
}