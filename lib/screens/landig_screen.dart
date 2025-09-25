import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LandigScreen extends StatelessWidget {
  const LandigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.secondaryColor, // Usando el color secundario como fondo
      body: SafeArea(
        child: Column(
          children: [
            // Área superior con ilustración
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Stack para las estrellas y la imagen principal
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Imagen principal de personas en el banco
                        Container(
                          width: 220,
                          height: 140,
                          child: Image.asset(
                            'assets/images/people_on_bench.png', // Coloca tu imagen aquí
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Área inferior con contenido
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppConstants.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largePadding + 8,
                  vertical: AppConstants.largePadding + 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Título principal
                    Text(
                      'Comencemos a Crecer\nNuestras Habilidades',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textColor,
                        height: 1.3,
                      ),
                    ),
                    
                    // Subtítulo
                    Text(
                      'Tu tiempo de crecimiento y desarrollo personal\nempieza.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConstants.textColor.withOpacity(0.6),
                        height: 1.4,
                      ),
                    ),
                    
                    // Botón Comenzar
                    Container(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción del botón
                          print('Comenzar');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          'Comenzar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    
                    // Logo de la aplicación
                    Container(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        'assets/images/logo.png', // Coloca tu logo aquí
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
