import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/providers/auth_provider.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/widgets/custom_text_field.dart';
import 'package:vinculo/widgets/custom_button.dart';
import 'package:vinculo/models/user_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
    final authState = ref.watch(authProvider);
    final isLoading = authState == AuthState.loading;

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
                padding: const EdgeInsets.symmetric(
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
                          const Text(
                            AppConstants.appName,
                            style: TextStyle(
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

                      // Información de usuarios de prueba
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Usuarios de prueba:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryColor,
                                fontFamily: 'Public Sans',
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Adulto Mayor:\nelena@mail.com / 123456',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppConstants.textColor,
                                fontFamily: 'Public Sans',
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Voluntario:\ncarlos@mail.com / 123456',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppConstants.textColor,
                                fontFamily: 'Public Sans',
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

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
                              if (isLoading)
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: AppConstants.primaryColor,
                                  ),
                                )
                              else
                                CustomButton(
                                  text: 'Iniciar Sesión',
                                  onPressed: _handleLogin,
                                  color: AppConstants.primaryColor,
                                  textColor: AppConstants.backgroundColor,
                                ),

                              const SizedBox(
                                height: AppConstants.defaultPadding,
                              ),

                              // Botón de registro
                              CustomButton(
                                text: 'Registro',
                                onPressed: () {
                                  context.push('/registro'); // ← CAMBIO AQUÍ
                                },
                                color: Colors.white,
                                textColor: AppConstants.primaryColor,
                              ),
                            ],
                          ),

                          const SizedBox(height: AppConstants.largePadding),

                          // Enlace de contraseña olvidada
                          TextButton(
                            onPressed: _handleForgotPassword,
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

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Por favor completa todos los campos');
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);
    final result = await authNotifier.login(email, password);

    if (result.isSuccess && result.user != null) {
      // Guardar usuario actual
      ref.read(currentUserProvider.notifier).state = result.user;

      if (!mounted) return;

      // Navegar según el tipo de usuario
      if (result.user!.type == UserType.elderly) {
        // Home para adulto mayor
        context.go('/elderly/home'); 
      } else {
        // Home para voluntario
        context.go('/volunteer/home'); 
      }
    } else {
      _showError(result.errorMessage ?? 'Error al iniciar sesión');
    }
  }

  void _handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de recuperar contraseña'),
        backgroundColor: AppConstants.secondaryColor,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.accentColorLight,
      ),
    );
  }
}
