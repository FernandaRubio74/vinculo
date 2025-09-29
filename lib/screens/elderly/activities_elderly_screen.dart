import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final List<ActivityOption> _activities = [
    ActivityOption(
      title: 'Videollamada',
      icon: Icons.videocam,
      onTap: () {},
    ),
    ActivityOption(
      title: 'Conversar',
      icon: Icons.chat,
      onTap: () {},
    ),
    ActivityOption(
      title: 'Aprender',
      icon: Icons.school,
      onTap: () {},
    ),
    ActivityOption(
      title: 'Narrar Historias',
      icon: Icons.auto_stories,
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppConstants.backgroundDark // Usa tu constante
          : AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
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
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                    icon: Icon(
                      Icons.settings,
                      color: isDark
                          ? AppConstants.backgroundColor.withOpacity(0.8)
                          : AppConstants.backgroundDark.withOpacity(0.8),
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

                    // Título principal
                    Text(
                      'Actividades de Hoy',
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

                    const SizedBox(height: 48),

                    // Grid de actividades
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppConstants.largePadding,
                          mainAxisSpacing: AppConstants.largePadding,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: _activities.length,
                        itemBuilder: (context, index) {
                          final activity = _activities[index];
                          return _buildActivityCard(context, activity, isDark);
                        },
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

      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildActivityCard(BuildContext context, ActivityOption activity, bool isDark) {
    return GestureDetector(
      onTap: () => _handleActivityTap(context, activity),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppConstants.backgroundDark.withOpacity(0.5)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isDark ? 12 : 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                activity.icon,
                size: 40,
                color: AppConstants.primaryColor,
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            // Título
            Text(
              activity.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppConstants.backgroundColor
                    : AppConstants.backgroundDark,
                fontFamily: 'Public Sans',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.backgroundDark.withOpacity(0.5)
            : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
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
                    onTap: () => Navigator.pushReplacementNamed(context, '/home_elderly'),
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.person,
                    label: 'Perfil',
                    isActive: false,
                    onTap: () => Navigator.pushReplacementNamed(context, '/profile_elderly'),
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.local_activity,
                    label: 'Actividades',
                    isActive: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                    ? AppConstants.backgroundColor.withOpacity(0.5)
                    : AppConstants.backgroundDark.withOpacity(0.5)),
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
                      ? AppConstants.backgroundColor.withOpacity(0.5)
                      : AppConstants.backgroundDark.withOpacity(0.5)),
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              fontFamily: 'Public Sans',
            ),
          ),
        ],
      ),
    );
  }

  void _handleActivityTap(BuildContext context, ActivityOption activity) {
    if (activity.title == 'Videollamada') {
      Navigator.pushReplacementNamed(context, '/video_call');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Iniciando ${activity.title}...'),
          backgroundColor: AppConstants.primaryColor,
        ),
      );
    }
  }
}

// Clase para representar una opción de actividad
class ActivityOption {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  ActivityOption({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
