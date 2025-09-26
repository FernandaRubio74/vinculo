import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.secondaryColor, // Color azul oscuro
      body: Stack(
        children: [
          // Círculos decorativos de fondo
          Positioned(
            left: -146,
            bottom: 200,
            child: Opacity(
              opacity: 0.05,
              child: Container(
                width: 293.53,
                height: 293.53,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Positioned(
            right: -146,
            bottom: 200,
            child: Opacity(
              opacity: 0.05,
              child: Container(
                width: 293.53,
                height: 293.53,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          
          // Contenedor blanco inferior
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 310,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Área de texto principal
                  Container(
                    width: double.infinity,
                    height: 193,
                    padding: const EdgeInsets.only(top: 27),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Título principal con texto destacado
                        SizedBox(
                          width: 325,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Comencemos a ',
                                  style: TextStyle(
                                    color: Color(0xFF0C0A1C),
                                    fontSize: 28,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                    letterSpacing: 0.42,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Crecer',
                                  style: TextStyle(
                                    color: AppConstants.primaryColor,
                                    fontSize: 28,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    height: 1.50,
                                    letterSpacing: 0.42,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' Nuestras Habilidades',
                                  style: TextStyle(
                                    color: Color(0xFF0C0A1C),
                                    fontSize: 28,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                    letterSpacing: 0.42,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Subtítulo
                        SizedBox(
                          width: 265,
                          child: Opacity(
                            opacity: 0.65,
                            child: const Text(
                              'La app que conecta generaciones para aprender, crecer y compartir experiencias juntos.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1B163F),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                                height: 1.50,
                                letterSpacing: 0.18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Área inferior con logo y botón
                  Container(
                    height: 87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo/Avatar circular
                        Container(
                          width: 105,
                          height: 105,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/logo.png'), // Tu logo/avatar
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Botón Comenzar
                        Container(
                          width: 221,
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: AppConstants.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Navegación a la siguiente pantalla
                              Navigator.pushNamed(context, '/registro');
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Comenzar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 1.50,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Imagen principal de las personas en el banco (ENCIMA del área blanca)
          Positioned(
            left: 10,
            bottom: 250, // Ajustado para que se superponga sobre el área blanca
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 400, // Altura reducida para mejor proporción
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/people_on_bench_large.png'), // Tu imagen principal
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}