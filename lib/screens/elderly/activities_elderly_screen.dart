import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/config/providers/active_connections_provider.dart';

class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeNotifierProvider).isDarkMode;
    final activeConnections = ref.watch(activeConnectionsProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppConstants.backgroundDark
          : AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
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
                        color: AppConstants.primaryColor,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.go('/settings'),
                    icon: Icon(
                      Icons.settings,
                      color: isDark ? AppConstants.hintColor : AppConstants.textColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            // Contenido principal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largePadding,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: AppConstants.largePadding),
                    Text(
                      'Tus Conexiones', 
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppConstants.backgroundColor
                            : AppConstants.backgroundDark,
                        fontFamily: 'Public Sans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Inicia una videollamada o chat con tus amigos.', 
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? AppConstants.hintColor : Colors.grey.shade700,
                        fontFamily: 'Public Sans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),


                    Expanded(
                      child: activeConnections.when(
                        loading: () => const Center(
                          child: CircularProgressIndicator(color: AppConstants.primaryColor),
                        ),
                        error: (err, stack) => Center(
                          child: Text('Error al cargar conexiones: ${err.toString()}'),
                        ),
                        data: (connections) {
                          if (connections.isEmpty) {
                            return Center(
                              child: Text(
                                'Aún no tienes conexiones.\n¡Ve a Inicio para encontrar voluntarios!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: connections.length,
                            itemBuilder: (context, index) {
                              final user = connections[index];
                              return _buildConnectionCard(context, user, isDark);
                            },
                          );
                        },
                      ),
                    ),
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

 
  Widget _buildConnectionCard(BuildContext context, UserModel user, bool isDark) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? AppConstants.backgroundDark.withOpacity(0.8) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.primaryColor.withOpacity(0.2),
              ),
              child: const Icon(Icons.person, size: 30, color: AppConstants.primaryColor),
            ),
            const SizedBox(width: AppConstants.defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                  Text(
                    user.bio ?? 'Conectado',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppConstants.hintColor : Colors.grey.shade700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Botón de Videollamada
            IconButton(
              onPressed: () {
                context.pushNamed(
                  'videocall', 
                  queryParameters: {'contact': user.fullName}
                );
              },
              icon: const Icon(Icons.videocam, color: AppConstants.primaryColor, size: 30),
            ),
          ],
        ),
      ),
    );
  }

 
  Widget _buildBottomNavigation(BuildContext context, bool isDark) {
     return Container(
      decoration: BoxDecoration(
        color: (isDark
                ? AppConstants.backgroundDark
                : AppConstants.backgroundColor)
            .withOpacity(0.95),
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.grey.shade700.withOpacity(0.5)
                : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: 8,
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
                icon: Icons.person_outline,
                label: 'Perfil',
                isActive: false,
                isDark: isDark,
                onTap: () => context.goNamed('elderly-profile'),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.local_activity,
                label: 'Actividades',
                isActive: true,
                isDark: isDark,
                onTap: () {},
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
            size: 24,
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
}