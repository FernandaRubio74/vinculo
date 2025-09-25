import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  
  const HomeScreen({
    super.key,
    required this.userName,
  });

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.appName),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con saludo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConstants.largePadding),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppConstants.welcomeMessage}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textColor,
                      ),
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.largePadding),
              
              // Grid de opciones principales
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.defaultPadding,
                  mainAxisSpacing: AppConstants.defaultPadding,
                  children: [
                    _buildFeatureCard(
                      icon: Icons.dashboard,
                      title: 'Dashboard',
                      subtitle: 'Ver estadísticas',
                      onTap: () => _showFeatureDialog(context, 'Dashboard'),
                    ),
                    _buildFeatureCard(
                      icon: Icons.person,
                      title: 'Perfil',
                      subtitle: 'Configuración',
                      onTap: () => _showFeatureDialog(context, 'Perfil'),
                    ),
                    _buildFeatureCard(
                      icon: Icons.settings,
                      title: 'Ajustes',
                      subtitle: 'Personalizar app',
                      onTap: () => _showFeatureDialog(context, 'Ajustes'),
                    ),
                    _buildFeatureCard(
                      icon: Icons.help,
                      title: 'Ayuda',
                      subtitle: 'Soporte técnico',
                      onTap: () => _showFeatureDialog(context, 'Ayuda'),
                    ),
                  ],
                ),
              ),
              
              // Botones de acción
              const SizedBox(height: AppConstants.defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Acción Principal',
                      onPressed: () => _showFeatureDialog(context, 'Acción Principal'),
                    ),
                  ),
                  const SizedBox(width: AppConstants.defaultPadding),
                  Expanded(
                    child: CustomButton(
                      text: 'Configurar',
                      onPressed: () => _showFeatureDialog(context, 'Configurar'),
                      color: AppConstants.secondaryColor,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Botón de cerrar sesión
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text('Cerrar Sesión'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: AppConstants.primaryColor,
              ),
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppConstants.hintColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeatureDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$feature'),
          content: Text('Has seleccionado la función: $feature\n\nEsta funcionalidad está en desarrollo.'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}