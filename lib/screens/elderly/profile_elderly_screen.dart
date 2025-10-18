import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';

class ProfileElderlyScreen extends ConsumerStatefulWidget {
  final String userName;
  final int userAge;
  final List<String> userInterests;

  const ProfileElderlyScreen({
    super.key,
    this.userName = 'Elena Ramirez',
    this.userAge = 78,
    this.userInterests = const ['Jardinería', 'Lectura', 'Caminatas'],
  });

  @override
  ConsumerState<ProfileElderlyScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileElderlyScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      backgroundColor: isDark
          ? AppConstants.backgroundDark
          : AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header fijo
            Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              decoration: BoxDecoration(
                color: isDark
                    ? AppConstants.backgroundDark
                    : AppConstants.backgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 48), // Espacio para balance
                  const Expanded(
                    child: Text(
                      AppConstants.appName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Public Sans',
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.go('/settings'),
                    icon: Icon(
                      Icons.settings,
                      color: isDark
                          ? AppConstants.hintColor
                          : AppConstants.textColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            // Contenido principal scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                child: Column(
                  children: [
                    const SizedBox(height: AppConstants.defaultPadding),

                    // Información del perfil
                    Column(
                      children: [
                        // Foto de perfil
                        Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.primaryColor.withOpacity(0.2),
                            boxShadow: [
                              BoxShadow(
                                color: isDark 
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.1),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 64,
                            color: AppConstants.primaryColor,
                          ),
                        ),

                        const SizedBox(height: AppConstants.defaultPadding),

                        // Nombre
                        Text(
                          widget.userName,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppConstants.hintColor
                                : AppConstants.textColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),

                        const SizedBox(height: AppConstants.smallPadding),

                        // Edad
                        Text(
                          '${widget.userAge} años',
                          style: TextStyle(
                            fontSize: 18,
                            color: isDark
                                ? AppConstants.hintColor.withOpacity(0.7)
                                : AppConstants.textColor.withOpacity(0.7),
                            fontFamily: 'Public Sans',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Sección de intereses
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Intereses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppConstants.hintColor
                                : AppConstants.textColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),

                        const SizedBox(height: AppConstants.defaultPadding),

                        // Tags de intereses
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: widget.userInterests.map((interest) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.defaultPadding,
                                vertical: AppConstants.smallPadding,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppConstants.primaryColor.withOpacity(0.3)
                                    : AppConstants.primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppConstants.primaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                interest,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppConstants.hintColor
                                      : AppConstants.primaryColor,
                                  fontFamily: 'Public Sans',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Botones de acción
                    Column(
                      children: [
                        // Botón Editar Perfil
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _editProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: isDark ? 8 : 2,
                              shadowColor: isDark
                                  ? AppConstants.primaryColor.withOpacity(0.5)
                                  : AppConstants.primaryColor.withOpacity(0.3),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Editar Perfil',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Public Sans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: AppConstants.defaultPadding),

                        // Botón Historial de Interacciones
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _viewHistory,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? AppConstants.backgroundDark.withOpacity(0.5)
                                  : AppConstants.hintColor,
                              foregroundColor: isDark
                                  ? AppConstants.hintColor
                                  : AppConstants.textColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: isDark
                                      ? AppConstants.hintColor.withOpacity(0.3)
                                      : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              elevation: isDark ? 4 : 2,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.history, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Historial de Interacciones',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Public Sans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 100), // Espacio para navegación
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavigation(context, isDark),
    );
  }

  Widget _buildBottomNavigation(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.backgroundDark
            : AppConstants.backgroundColor,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ]
            : [],
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
                context: context,
                icon: Icons.home,
                label: 'Inicio',
                isActive: false,
                isDark: isDark,
                onTap: () => context.go('/elderly/home'),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.person,
                label: 'Perfil',
                isActive: true,
                isDark: isDark,
                onTap: () {},
              ),
              _buildNavItem(
                context: context,
                icon: Icons.local_activity,
                label: 'Actividades',
                isActive: false,
                isDark: isDark,
                onTap: () => context.go('/elderly/activities'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive
                ? AppConstants.primaryColor
                : (isDark 
                    ? AppConstants.hintColor.withOpacity(0.5)
                    : AppConstants.textColor.withOpacity(0.5)),
            size: 30,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive
                  ? AppConstants.primaryColor
                  : (isDark 
                      ? AppConstants.hintColor.withOpacity(0.5)
                      : AppConstants.textColor.withOpacity(0.5)),
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              fontFamily: 'Public Sans',
            ),
          ),
        ],
      ),
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = ref.watch(themeNotifierProvider).isDarkMode;
        return AlertDialog(
          backgroundColor: isDark 
              ? AppConstants.backgroundDark 
              : AppConstants.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            'Editar Perfil',
            style: TextStyle(
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryColor,
            ),
          ),
          content: Text(
            'Funcionalidad para editar tu perfil personal, cambiar foto, actualizar intereses y información de contacto.',
            style: TextStyle(
              fontFamily: 'Public Sans', 
              fontSize: 16,
              color: isDark 
                  ? AppConstants.hintColor 
                  : AppConstants.textColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'Cerrar',
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

  void _viewHistory() {
    // Nota: Asume que hay una ruta de historial para elderly
    // Ajusta según tu go_router configuration
    context.go('/elderly/history');
  }
}