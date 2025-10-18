import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ← NUEVO IMPORT
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/widgets/custom_header.dart';
import 'package:vinculo/widgets/custom_text_field.dart';

class RegisterGeneralScreen extends StatefulWidget {
  const RegisterGeneralScreen({super.key});

  @override
  State<RegisterGeneralScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterGeneralScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header con botón de retroceso
            const CustomHeader(showBack: true),
            // Contenido principal scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largePadding,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: AppConstants.smallPadding),

                    // Icono y título
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(
                            AppConstants.defaultPadding,
                          ),
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
                          'Crea tu cuenta',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: AppConstants.smallPadding),
                        Text(
                          'Únete a nuestra comunidad para conectar con tus seres queridos.',
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

                    // Formulario
                    Column(
                      children: [
                        // Campo Nombre
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Nombre completo',
                          keyboardType: TextInputType.name,
                          prefixIcon: Icons.person_outline,
                        ),

                        const SizedBox(height: 20),

                        // Campo Email
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Correo electrónico',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 20),

                        // Campo Contraseña
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Crea una contraseña',
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

                    // Botón de registro
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: _handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          shadowColor: AppConstants.primaryColor.withOpacity(
                            0.39,
                          ),
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

                    // Link para iniciar sesión
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
                          onPressed: () => context.pop(), // ← CAMBIO 1
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

            // Bottom Navigation
            Container(
              decoration: BoxDecoration(
                color: AppConstants.backgroundColor,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        icon: Icons.home,
                        label: 'Inicio',
                        isActive: false,
                      ),
                      _buildNavItem(
                        icon: Icons.person,
                        label: 'Perfil',
                        isActive: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive
              ? AppConstants.primaryColor
              : AppConstants.textColor.withOpacity(0.5),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive
                ? AppConstants.primaryColor
                : AppConstants.textColor.withOpacity(0.5),
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontFamily: 'Public Sans',
          ),
        ),
      ],
    );
  }

  void _handleRegister() {
    // Validación de campos
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: AppConstants.accentColorLight,
        ),
      );
      return;
    }
    
    // Navegar a la siguiente pantalla (selección de rol)
    context.go('/roles'); // ← CAMBIO 2
  }
}