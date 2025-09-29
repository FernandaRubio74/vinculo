import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Ajustes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Apariencia
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Apariencia",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: const Text("Tema"),
              subtitle: Text(isDarkMode ? "Oscuro" : "Claro"),
              value: isDarkMode,
              activeColor: AppConstants.primaryColor,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ),

          /// Notificaciones
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Notificaciones",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: const Text("Notificaciones"),
              subtitle: const Text(
                "Recibir notificaciones sobre nuevas actividades y actualizaciones.",
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

          /// Privacidad y Accesibilidad
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Privacidad y Accesibilidad",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text("Configuración de privacidad"),
                  subtitle: const Text(
                    "Gestionar la visibilidad de tu perfil y datos.",
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showPrivacyDialog(context);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text("Tamaño del texto"),
                  subtitle: const Text(
                    "Ajustar el tamaño del texto para una mejor legibilidad.",
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showTextSizeDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Sin BottomNavigationBar - la navegación se maneja desde donde se llama
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
          'Aquí podrás gestionar la visibilidad de tu perfil y datos.',
          style: TextStyle(fontFamily: 'Public Sans'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cerrar',
              style: TextStyle(
                color: AppConstants.primaryColor,
                fontFamily: 'Public Sans',
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
          'Funcionalidad para ajustar el tamaño del texto.',
          style: TextStyle(fontFamily: 'Public Sans'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cerrar',
              style: TextStyle(
                color: AppConstants.primaryColor,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}