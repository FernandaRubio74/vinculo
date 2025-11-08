import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/config/providers/auth_provider.dart';


class ProfileElderlyScreen extends ConsumerWidget {
  const ProfileElderlyScreen({super.key});

  
  int _calculateAge(String? birthDateString) {
    if (birthDateString == null || birthDateString.isEmpty) {
      return 0;
    }
    try {
      final birthDate = DateTime.parse(birthDateString);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || 
         (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0; 
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeNotifierProvider).isDarkMode;
    final user = ref.watch(currentUserProvider);

    
    if (user == null) {
      return Scaffold(
        backgroundColor: isDark ? AppConstants.backgroundDark : AppConstants.backgroundColor,
        body: const Center(
          child: CircularProgressIndicator(color: AppConstants.primaryColor),
        ),
      );
    }


    final int userAge = _calculateAge(user.birthDate);

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
                  const SizedBox(width: 48), 
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
                    onPressed: () => context.pushNamed('settings'), 
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


            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                child: Column(
                  children: [
                    const SizedBox(height: AppConstants.defaultPadding),

                    // Información del perfil
                    Column(
                      children: [
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


                        Text(
                          user.fullName,
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


                        Text(
                          '$userAge años',
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


                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: user.interests.map((interest) {
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
                                interest.name, 
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
                            onPressed: () => _editProfile(context, ref, isDark),
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
                            onPressed: () => _viewHistory(context),
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
                    const SizedBox(height: 100), 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
            ? [ BoxShadow( color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, -2),),]
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
                onTap: () => context.goNamed('elderly-home'), 
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
                onTap: () => context.goNamed('activities-elderly'), 
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

  void _editProfile(BuildContext context, WidgetRef ref, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
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

  void _viewHistory(BuildContext context) {
    context.pushNamed('history');
  }
}