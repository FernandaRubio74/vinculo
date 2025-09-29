import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      backgroundColor: isDark
          ? AppConstants.backgroundDark
          : AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
          ),
        ),
        title: Text(
          'Historial',
          style: TextStyle(
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Public Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de Resumen
            _buildSummarySection(isDark),

            const SizedBox(height: 32),

            // Sección de Videollamadas
            _buildVideoCallsSection(isDark),

            const SizedBox(height: 32),

            // Sección de Otras Interacciones
            _buildOtherInteractionsSection(isDark),

            const SizedBox(height: 100), // Espacio para navegación inferior
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context, isDark),
    );
  }

  Widget _buildSummarySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resumen',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                title: 'Sesiones\nCompletadas',
                value: '18',
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildSummaryCard(
                title: 'Horas de\nVoluntariado',
                value: '32',
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.primaryColor.withOpacity(0.2)
            : AppConstants.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: isDark
            ? Border.all(
                color: AppConstants.primaryColor.withOpacity(0.4),
                width: 1,
              )
            : null,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppConstants.hintColor.withOpacity(0.8)
                  : AppConstants.textColor.withOpacity(0.7),
              fontFamily: 'Public Sans',
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryColor,
              fontFamily: 'Public Sans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCallsSection(bool isDark) {
    final videoCalls = [
      {
        'name': 'María González',
        'date': '15 de mayo de 2024',
        'duration': '50 min',
      },
      {
        'name': 'José Pérez',
        'date': '12 de mayo de 2024',
        'duration': '45 min',
      },
      {
        'name': 'Ana Rodríguez',
        'date': '8 de mayo de 2024',
        'duration': '35 min',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Videollamadas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 16),

        ...videoCalls.map((call) => _buildVideoCallCard(call, isDark)),
      ],
    );
  }

  Widget _buildVideoCallCard(Map<String, String> call, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.backgroundDark.withOpacity(0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isDark
            ? Border.all(
                color: AppConstants.primaryColor.withOpacity(0.2),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icono de videollamada
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark
                  ? AppConstants.primaryColor.withOpacity(0.3)
                  : AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.videocam,
              color: AppConstants.primaryColor,
              size: 20,
            ),
          ),

          const SizedBox(width: 16),

          // Información de la llamada
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Llamada con ${call['name']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppConstants.hintColor
                        : AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${call['date']} • ${call['duration']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppConstants.hintColor.withOpacity(0.7)
                        : AppConstants.textColor.withOpacity(0.7),
                    fontFamily: 'Public Sans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherInteractionsSection(bool isDark) {
    final interactions = [
      {
        'title': 'Visita a la residencia \'Amanecer\'',
        'date': '10 de mayo de 2024',
        'icon': Icons.home_work,
      },
      {
        'title': 'Taller de manualidades en \'Sol Dorado\'',
        'date': '25 de abril de 2024',
        'icon': Icons.build,
      },
      {
        'title': 'Acompañamiento en el parque \'Primavera\'',
        'date': '12 de abril de 2024',
        'icon': Icons.park,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Otras Interacciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 16),

        ...interactions.map((interaction) => _buildInteractionCard(interaction, isDark)),
      ],
    );
  }

  Widget _buildInteractionCard(Map<String, dynamic> interaction, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.backgroundDark.withOpacity(0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isDark
            ? Border.all(
                color: AppConstants.primaryColor.withOpacity(0.2),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icono de la interacción
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark
                  ? AppConstants.primaryColor.withOpacity(0.3)
                  : AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              interaction['icon'],
              color: AppConstants.primaryColor,
              size: 20,
            ),
          ),

          const SizedBox(width: 16),

          // Información de la interacción
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  interaction['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppConstants.hintColor
                        : AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  interaction['date'],
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppConstants.hintColor.withOpacity(0.7)
                        : AppConstants.textColor.withOpacity(0.7),
                    fontFamily: 'Public Sans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context, bool isDark) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.backgroundDark
            : AppConstants.backgroundColor,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/volunteer_home');
            },
            child: _buildNavItem(
              icon: Icons.home,
              label: 'Inicio',
              isActive: false,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/matches');
            },
            child: _buildNavItem(
              icon: Icons.people,
              label: 'Matches',
              isActive: false,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/rewards');
            },
            child: _buildNavItem(
              icon: Icons.card_giftcard,
              label: 'Recompensas',
              isActive: false,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
            child: _buildNavItem(
              icon: Icons.person,
              label: 'Perfil',
              isActive: true,
              isDark: isDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isDark,
  }) {
    return Column(
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
    );
  }
}