import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

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
          'Perfil',
          style: TextStyle(
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Public Sans',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/history'),
            icon: Icon(
              Icons.history,
              color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: Icon(
              Icons.settings,
              color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // Sección de perfil del usuario
            _buildProfileHeader(context, isDark),

            const SizedBox(height: 32),

            // Estadísticas
            _buildStatsSection(isDark),

            const SizedBox(height: 32),

            // Calendario de Actividades
            _buildCalendarSection(isDark),

            const SizedBox(height: 24),

            // Próximas actividades
            _buildUpcomingActivities(isDark),

            const SizedBox(height: 32),

            // Habilidades
            _buildSkillsSection(isDark),

            const SizedBox(height: 32),

            // Disponibilidad
            _buildAvailabilitySection(isDark),

            const SizedBox(height: 100), // Espacio para navegación inferior
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context, isDark),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDark) {
    return Column(
      children: [
        // Avatar con verificación
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? Colors.orange.shade800.withOpacity(0.3)
                    : Colors.orange.shade200,
                border: Border.all(
                  color: AppConstants.primaryColor,
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.person,
                size: 50,
                color: isDark ? Colors.orange.shade300 : Colors.orange.shade800,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Nombre y tipo de usuario
        Text(
          'Carlos Mendoza',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Voluntario',
          style: TextStyle(
            fontSize: 16,
            color: isDark
                ? AppConstants.hintColor.withOpacity(0.7)
                : AppConstants.textColor.withOpacity(0.7),
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 16),

        // Botón Ver Historial
        OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/history'),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppConstants.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
          icon: const Icon(
            Icons.history,
            size: 16,
            color: AppConstants.primaryColor,
          ),
          label: const Text(
            'Ver Historial',
            style: TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Public Sans',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            value: '150',
            label: 'Horas de\nvoluntariado',
            color: AppConstants.primaryColor,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildStatCard(
            value: '25',
            label: 'Recompensas',
            color: AppConstants.primaryColor,
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? color.withOpacity(0.2)
            : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? color.withOpacity(0.4)
              : color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Public Sans',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppConstants.hintColor.withOpacity(0.8)
                  : AppConstants.textColor.withOpacity(0.7),
              fontFamily: 'Public Sans',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calendario de Actividades',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 16),

        // Header del calendario
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isDark
                ? AppConstants.backgroundDark.withOpacity(0.5)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chevron_left,
                  color: isDark
                      ? AppConstants.hintColor
                      : AppConstants.textColor,
                ),
              ),
              Text(
                'Junio 2024',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Public Sans',
                  color: isDark
                      ? AppConstants.hintColor
                      : AppConstants.textColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chevron_right,
                  color: isDark
                      ? AppConstants.hintColor
                      : AppConstants.textColor,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Días de la semana
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['D', 'L', 'M', 'X', 'J', 'V', 'S'].map((day) {
            return Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppConstants.hintColor.withOpacity(0.7)
                      : AppConstants.textColor.withOpacity(0.7),
                  fontFamily: 'Public Sans',
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 8),

        // Calendario simplificado
        _buildCalendarGrid(isDark),
      ],
    );
  }

  Widget _buildCalendarGrid(bool isDark) {
    final daysInMonth = 30;
    final startDay = 6; // Junio 2024 empieza en sábado (índice 6)

    return SizedBox(
      height: 200,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: 42, // 6 semanas
        itemBuilder: (context, index) {
          final dayNumber = index - startDay + 1;

          if (dayNumber < 1 || dayNumber > daysInMonth) {
            return const SizedBox();
          }

          final hasActivity =
              dayNumber == 5 || dayNumber == 18; // Días con actividades
          final isToday = dayNumber == 5;

          return Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isToday ? AppConstants.primaryColor : Colors.transparent,
              shape: BoxShape.circle,
              border: hasActivity && !isToday
                  ? Border.all(color: AppConstants.primaryColor, width: 2)
                  : null,
            ),
            child: Center(
              child: Text(
                dayNumber.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isToday
                      ? Colors.white
                      : hasActivity
                          ? AppConstants.primaryColor
                          : isDark
                              ? AppConstants.hintColor
                              : AppConstants.textColor,
                  fontFamily: 'Public Sans',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUpcomingActivities(bool isDark) {
    final activities = [
      {
        'day': 'MIÉ',
        'date': '5',
        'title': 'Acompañamiento a María G.',
        'time': '10:00-11:00',
        'subtitle': 'Paseo por el parque',
      },
      {
        'day': 'MAR',
        'date': '18',
        'title': 'Clase de tecnología a Juan P.',
        'time': '16:00-17:00',
        'subtitle': 'Videollamadas con familiares',
      },
    ];

    return Column(
      children:
          activities.map((activity) => _buildActivityCard(activity, isDark)).toList(),
    );
  }

  Widget _buildActivityCard(Map<String, String> activity, bool isDark) {
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
          // Fecha
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Text(
                  activity['day']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.primaryColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                Text(
                  activity['date']!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title']!,
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
                  activity['time']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppConstants.hintColor.withOpacity(0.7)
                        : AppConstants.textColor.withOpacity(0.7),
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['subtitle']!,
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

  Widget _buildSkillsSection(bool isDark) {
    final skills = ['Primeros auxilios', 'Acompañamiento', 'Tecnología'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Habilidades',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? AppConstants.primaryColor.withOpacity(0.3)
                    : AppConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppConstants.primaryColor.withOpacity(0.5)
                      : AppConstants.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppConstants.hintColor
                      : AppConstants.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Public Sans',
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAvailabilitySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disponibilidad',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? AppConstants.backgroundDark.withOpacity(0.5)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark
                  ? AppConstants.primaryColor.withOpacity(0.2)
                  : Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Semanal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppConstants.hintColor
                      : AppConstants.textColor,
                  fontFamily: 'Public Sans',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lunes a viernes, 18:00-20:00',
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
              // Ya estamos en perfil, no hacer nada
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