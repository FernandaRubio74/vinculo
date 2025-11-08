import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/widgets/custom_header.dart';
import 'package:vinculo/widgets/custom_text_field.dart';
import 'package:vinculo/config/providers/auth_provider.dart'; 


class RegisterGeneralScreen extends ConsumerStatefulWidget {
  const RegisterGeneralScreen({super.key});

  @override
  ConsumerState<RegisterGeneralScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterGeneralScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState == AuthState.loading;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largePadding,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: AppConstants.smallPadding),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppConstants.defaultPadding),
                          decoration: BoxDecoration(
                            color: AppConstants.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_add,
                            size: 48,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),
                        const Text(
                          'Crea tu cuenta (Paso 1/2)',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: AppConstants.smallPadding),
                        Text(
                          'Ingresa tus datos básicos para iniciar.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppConstants.textColor.withOpacity(0.7),
                            fontFamily: 'Public Sans',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
 
                    Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Nombre completo (ej. Carlos Ramírez)',
                          keyboardType: TextInputType.name,
                          prefixIcon: Icons.person_outline,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Correo (ej. carlos@ejemplo.com)',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Contraseña (ej. Password123!)',
                          obscureText: true,
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirma tu contraseña',
                          obscureText: true,
                          prefixIcon: Icons.lock_outline,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppConstants.primaryColor,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: _handleNext,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConstants.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 8,
                                shadowColor: AppConstants.primaryColor.withOpacity(0.39),
                              ),
                              child: const Text(
                                'Siguiente',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Public Sans',
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: AppConstants.largePadding),
 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Ya tienes una cuenta? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppConstants.textColor.withOpacity(0.7),
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.goNamed('login'), 
                          child: const Text(
                            'Inicia sesión',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.primaryColor,
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
          ],
        ),
      ),
    );
  }

  void _handleNext() {

    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showError('Por favor completa todos los campos');
      return;
    }
    if (!_emailController.text.contains('@')) {
      _showError('Ingresa un correo electrónico válido');
      return;
    }
    if (_passwordController.text.length < 6) {
      _showError('La contraseña debe tener al menos 6 caracteres');
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      _showError('Las contraseñas no coinciden');
      return;
    }


    ref.read(registerDataProvider.notifier).state = {

      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
    };


    context.pushNamed('roles'); 
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