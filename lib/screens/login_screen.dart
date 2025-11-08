import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/providers/auth_provider.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/widgets/custom_text_field.dart';
import 'package:vinculo/widgets/custom_button.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final TextEditingController _emailController = TextEditingController(
    text: "andres@gmail.com",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "Rubio123!",
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isDark = ref.watch(themeNotifierProvider).isDarkMode;


    final authState = ref.watch(authProvider);
    final isLoading = authState == AuthState.loading;

    return Scaffold(

      backgroundColor: isDark
          ? AppConstants.backgroundDark
          : AppConstants.backgroundColor,
      body: Stack(
        children: [

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
                              color: AppConstants
                                  .primaryColor, 
                              fontFamily: 'Public Sans',
                            ),
                          ),
                          const SizedBox(height: AppConstants.smallPadding),
                          Text(
                            'Conectando generaciones',
                            style: TextStyle(
                              fontSize: 18,

                              color: isDark
                                  ? AppConstants.hintColor
                                  : AppConstants.textColor.withOpacity(0.8),
                              fontFamily: 'Public Sans',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 48),

 
                      const SizedBox(height: 24),

                      Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Correo (ej. maria@ejemplo.com)',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.mail_outline,
                          ),
                          const SizedBox(height: AppConstants.largePadding),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Contraseña (ej. Password123!)',
                            obscureText: true,
                            prefixIcon: Icons.lock_outline,
                          ),
                          const SizedBox(height: AppConstants.defaultPadding),


                          Column(
                            children: [
                              if (isLoading)
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: AppConstants.primaryColor,
                                  ),
                                )
                              else
                                CustomButton(
                                  text: 'Iniciar Sesión',
                                  onPressed:
                                      _handleLogin, 
                                  color: AppConstants.primaryColor,
                                  textColor: AppConstants.backgroundColor,
                                ),
                              const SizedBox(
                                height: AppConstants.defaultPadding,
                              ),
                              CustomButton(
                                text: 'Registro',
                                onPressed: () {
        
                                  context.pushNamed('register');
                                },
                                color: isDark
                                    ? AppConstants.backgroundDark
                                    : Colors.white,
                                textColor: AppConstants.primaryColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.largePadding),

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
      if (!mounted) return;


      if (result.user!.type == UserType.elderly) {
        context.goNamed('elderly-home');
      } else {
        context.goNamed('volunteer-home');
      }
    } else {
      _showError(result.errorMessage ?? 'Error al iniciar sesión');
    }
  }

  void _handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Funcionalidad de recuperar contraseña (no implementada)',
        ),
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
