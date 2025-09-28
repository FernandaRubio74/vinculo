import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/widgets/custom_text_field.dart'; // Agrega este import
import 'package:vinculo/widgets/custom_button.dart'; // Agrega este import

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Stack(
        children: [
          // Efectos de fondo
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.primaryColor.withOpacity(0.2),
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
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.secondaryColor.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.secondaryColor.withOpacity(0.1),
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),
          
          // Contenido principal
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.largePadding,
                  vertical: AppConstants.defaultPadding,
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Encabezado
                      Column(
                        children: [
                          Text(
                            AppConstants.appName,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                              color: AppConstants.primaryColor,
                              fontFamily: 'Public Sans',
                            ),
                          ),
                          const SizedBox(height: AppConstants.smallPadding),
                          Text(
                            'Conectando generaciones',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppConstants.textColor.withOpacity(0.8),
                              fontFamily: 'Public Sans',
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Formulario
                      Column(
                        children: [
                          // Campo de email
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Correo electrónico',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.mail_outline,
                          ),
                          
                          const SizedBox(height: AppConstants.largePadding),
                          
                          // Campo de contraseña
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Contraseña',
                            obscureText: true,
                            prefixIcon: Icons.lock_outline,
                          ),
                          
                          const SizedBox(height: AppConstants.defaultPadding),
                          
                          // Botones
                          Column(
                            children: [
                              // Botón de iniciar sesión
                              CustomButton(
                                text: 'Iniciar Sesión',
                                onPressed: _handleLogin,
                                color: AppConstants.primaryColor,
                                textColor: AppConstants.backgroundColor,
                              ),
                              
                              const SizedBox(height: AppConstants.defaultPadding),
                              
                              // Botón de registro
                              CustomButton(
                                text: 'Registro',
                                onPressed: () {
                                  Navigator.pushNamed(context, '/registro');
                                },
                                color: Colors.white,
                                textColor: AppConstants.primaryColor,
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: AppConstants.largePadding),
                          
                          // Enlace de contraseña olvidada
                          TextButton(
                            onPressed: () {
                              // Lógica de recuperar contraseña
                              _handleForgotPassword();
                            },
                            child: const Text(
                              '¿Olvidaste tu contraseña?',
                              style: TextStyle(
                                color: AppConstants.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Public Sans',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin() {
    // Implementar lógica de login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Iniciando sesión...'),
        backgroundColor: AppConstants.primaryColor,
      ),
    );
  }

  void _handleForgotPassword() {
    // Implementar lógica de recuperar contraseña
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de recuperar contraseña'),
        backgroundColor: AppConstants.secondaryColor,
      ),
    );
  }
}

// Placeholder para la pantalla de registro
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Pantalla de Registro\n(Próximamente)',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Public Sans',
          ),
        ),
      ),
    );
  }
}