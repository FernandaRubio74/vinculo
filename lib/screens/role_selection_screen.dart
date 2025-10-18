import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ← NUEVO IMPORT
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/widgets/custom_header.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            CustomHeader(
              showHelp: true,
              onHelp: () => _showHelpDialog(context),
            ),
            // Contenido principal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Título y subtítulo
                    Column(
                      children: [
                        const Text(
                          '¿Quién eres?',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: AppConstants.smallPadding),
                        Text(
                          'Selecciona tu rol para comenzar',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppConstants.textColor.withOpacity(0.6),
                            fontFamily: 'Public Sans',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 48),

                    // Opciones de rol
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          // Voluntario Joven
                          _buildRoleCard(
                            context: context,
                            title: 'Voluntario Joven',
                            icon: Icons.volunteer_activism,
                            onTap: () => _selectRole(context, 'volunteer'),
                          ),

                          const SizedBox(height: AppConstants.largePadding),

                          // Adulto Mayor
                          _buildRoleCard(
                            context: context,
                            title: 'Adulto Mayor',
                            icon: Icons.elderly,
                            onTap: () => _selectRole(context, 'senior'),
                          ),
                        ],
                      ),
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
                        isActive: true,
                      ),
                      _buildNavItem(
                        icon: Icons.person_outline,
                        label: 'Perfil',
                        isActive: false,
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

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.largePadding),
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Icono
            Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: AppConstants.primaryColor),
            ),

            const SizedBox(height: AppConstants.defaultPadding),

            // Título
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.textColor,
                fontFamily: 'Public Sans',
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

  void _selectRole(BuildContext context, String role) {
    if (role == 'senior') {
      context.push('/elderly/register'); // ← CAMBIO 1
    } else if (role == 'volunteer') {
      context.push('/volunteer/register'); // ← CAMBIO 2
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Rol seleccionado: $role'),
          backgroundColor: AppConstants.primaryColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Ayuda',
            style: TextStyle(
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryColor,
            ),
          ),
          content: const Text(
            '• Voluntario Joven: Si eres una persona joven que quiere ayudar y conectar con adultos mayores.\n\n'
            '• Adulto Mayor: Si eres una persona de la tercera edad que busca compañía y apoyo.',
            style: TextStyle(fontFamily: 'Public Sans', fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(), // ← CAMBIO 3
              child: const Text(
                'Entendido',
                style: TextStyle(
                  color: AppConstants.primaryColor,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}