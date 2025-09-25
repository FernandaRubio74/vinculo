import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      // Simulamos un login exitoso
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userName: _emailController.text.split('@')[0],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o ícono de la app
              const Icon(
                Icons.account_circle,
                size: 100,
                color: AppConstants.primaryColor,
              ),
              const SizedBox(height: AppConstants.largePadding),
              
              // Título
              const Text(
                AppConstants.loginTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              const SizedBox(height: AppConstants.smallPadding),
              
              const Text(
                'Ingresa tus credenciales para continuar',
                style: TextStyle(
                  fontSize: 16,
                  color: AppConstants.textColor,
                ),
              ),
              const SizedBox(height: AppConstants.largePadding),
              
              // Formulario
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo de email
                    CustomTextField(
                      hintText: 'Correo electrónico',
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    
                    // Campo de contraseña
                    CustomTextField(
                      hintText: 'Contraseña',
                      controller: _passwordController,
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),
                    const SizedBox(height: AppConstants.largePadding),
                    
                    // Botón de login
                    CustomButton(
                      text: 'Iniciar Sesión',
                      onPressed: _login,
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    
                    // Enlace para recuperar contraseña
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Función no implementada'),
                          ),
                        );
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: AppConstants.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Footer
              const Text(
                'Nueva versión 1.0.0',
                style: TextStyle(
                  color: AppConstants.hintColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}