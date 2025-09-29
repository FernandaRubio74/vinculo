import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark 
          ? AppConstants.backgroundDark 
          : AppConstants.hintColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              decoration: BoxDecoration(
                color: (isDark 
                    ? AppConstants.backgroundDark 
                    : AppConstants.hintColor).withOpacity(0.9),
                border: Border(
                  bottom: BorderSide(
                    color: isDark 
                        ? AppConstants.secondaryColor.withOpacity(0.3)
                        : Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDark 
                          ? AppConstants.hintColor 
                          : AppConstants.textColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Ajustes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark 
                            ? AppConstants.hintColor 
                            : AppConstants.backgroundDark,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Para balance
                ],
              ),
            ),

            // Contenido principal
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppConstants.smallPadding),

                    // Sección Apariencia
                    _buildSectionTitle('Apariencia', isDark),
                    const SizedBox(height: 12),
                    _buildSettingCard(
                      isDark: isDark,
                      child: SwitchListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                          vertical: 8,
                        ),
                        title: Text(
                          'Tema',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark 
                                ? AppConstants.hintColor 
                                : AppConstants.textColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        subtitle: Text(
                          isDarkMode ? 'Oscuro' : 'Claro',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark 
                                ? AppConstants.hintColor.withOpacity(0.7)
                                : AppConstants.textColor.withOpacity(0.6),
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        value: isDarkMode,
                        activeColor: AppConstants.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: AppConstants.largePadding),

                    // Sección Notificaciones
                    _buildSectionTitle('Notificaciones', isDark),
                    const SizedBox(height: 12),
                    _buildSettingCard(
                      isDark: isDark,
                      child: SwitchListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                          vertical: 8,
                        ),
                        title: Text(
                          'Notificaciones',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark 
                                ? AppConstants.hintColor 
                                : AppConstants.textColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        subtitle: Text(
                          'Recibir notificaciones sobre nuevas actividades y actualizaciones.',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark 
                                ? AppConstants.hintColor.withOpacity(0.7)
                                : AppConstants.textColor.withOpacity(0.6),
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        value: notificationsEnabled,
                        activeColor: AppConstants.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: AppConstants.largePadding),

                    // Sección Privacidad y Accesibilidad
                    _buildSectionTitle('Privacidad y Accesibilidad', isDark),
                    const SizedBox(height: 12),
                    _buildSettingCard(
                      isDark: isDark,
                      child: Column(
                        children: [
                          _buildSettingTile(
                            isDark: isDark,
                            title: 'Configuración de privacidad',
                            subtitle: 'Gestionar la visibilidad de tu perfil y datos.',
                            onTap: () => _showPrivacyDialog(context),
                          ),
                          Divider(
                            height: 1,
                            color: isDark 
                                ? AppConstants.secondaryColor.withOpacity(0.2)
                                : Colors.grey.shade200,
                          ),
                          _buildSettingTile(
                            isDark: isDark,
                            title: 'Tamaño del texto',
                            subtitle: 'Ajustar el tamaño del texto para una mejor legibilidad.',
                            onTap: () => _showTextSizeDialog(context),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppConstants.largePadding),

                    // Sección Cuenta
                    _buildSectionTitle('Cuenta', isDark),
                    const SizedBox(height: 12),
                    _buildSettingCard(
                      isDark: isDark,
                      child: Column(
                        children: [
                          _buildSettingTile(
                            isDark: isDark,
                            title: 'Cerrar sesión',
                            subtitle: 'Salir de tu cuenta actual',
                            icon: Icons.logout,
                            iconColor: AppConstants.accentColorLight,
                            onTap: () => _showLogoutDialog(context),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: AppConstants.smallPadding),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark 
              ? AppConstants.hintColor 
              : AppConstants.backgroundDark,
          fontFamily: 'Public Sans',
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required bool isDark,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark 
            ? AppConstants.backgroundDark 
            : AppConstants.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSettingTile({
    required bool isDark,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    IconData? icon,
    Color? iconColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 8,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: iconColor ?? (isDark 
              ? AppConstants.hintColor 
              : AppConstants.textColor),
          fontFamily: 'Public Sans',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: isDark 
              ? AppConstants.hintColor.withOpacity(0.7)
              : AppConstants.textColor.withOpacity(0.6),
          fontFamily: 'Public Sans',
        ),
      ),
      trailing: Icon(
        icon ?? Icons.chevron_right,
        color: isDark 
            ? AppConstants.hintColor.withOpacity(0.5)
            : AppConstants.textColor.withOpacity(0.5),
      ),
      onTap: onTap,
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Configuración de Privacidad',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        content: const Text(
          'Aquí podrás gestionar la visibilidad de tu perfil, controlar quién puede verte en línea y configurar tus preferencias de privacidad.',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
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
      ),
    );
  }

  void _showTextSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Tamaño del Texto',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        content: const Text(
          'Funcionalidad para ajustar el tamaño del texto en toda la aplicación para una mejor accesibilidad y legibilidad.',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
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
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          '¿Cerrar sesión?',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.accentColorLight,
          ),
        ),
        content: const Text(
          '¿Estás seguro de que deseas cerrar sesión?',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: AppConstants.primaryColor,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.accentColorLight,
            ),
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}