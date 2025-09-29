import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';

class VolunteerHomeScreen extends ConsumerWidget {
  const VolunteerHomeScreen({super.key});

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
        title: Text(
          'VínculoVital',
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
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saludo personalizado
            Text(
              '¡Hola, Carlos!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? AppConstants.hintColor : AppConstants.textColor,
                fontFamily: 'Public Sans',
              ),
            ),

            const SizedBox(height: 20),

            // Sección de Conexiones Destacadas
            _buildSectionTitle('Conexiones Destacadas', isDark),
            const SizedBox(height: 12),
            _buildFeaturedConnections(isDark),

            // Botón "Ver Conexiones"
            const SizedBox(height: 16),
            _buildViewConnectionsButton(context, isDark),

            const SizedBox(height: 20),

            // Sección de Anuncios para Voluntarios
            _buildSectionTitle('Anuncios para Voluntarios', isDark),
            const SizedBox(height: 12),
            _buildAnnouncementCard(isDark),

            const SizedBox(height: 20),

            // Sección de Progreso de Recompensas
            _buildSectionTitle('Progreso de Recompensas', isDark),
            const SizedBox(height: 12),
            _buildRewardsProgress(isDark),

            const SizedBox(height: 20),

            // Acciones rápidas mejoradas
            _buildQuickActions(context, isDark),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context, isDark),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: isDark ? AppConstants.hintColor : AppConstants.textColor,
        fontFamily: 'Public Sans',
      ),
    );
  }

  Widget _buildFeaturedConnections(bool isDark) {
    final connections = [
      {'name': 'Carlos', 'status': 'Próxima sesión:\nMañana'},
      {'name': 'Elena', 'status': 'Próxima sesión: 2 días'},
      {'name': 'Roberto', 'status': 'Próxima ses...'},
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: connections.length,
        itemBuilder: (context, index) {
          final connection = connections[index];
          return Container(
            width: 85,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                // Avatar circular
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    border: Border.all(
                      color: AppConstants.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 25,
                    color: isDark
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                // Nombre
                Text(
                  connection['name']!,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppConstants.hintColor
                        : AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                // Estado
                Flexible(
                  child: Text(
                    connection['status']!,
                    style: TextStyle(
                      fontSize: 9,
                      color: isDark
                          ? AppConstants.hintColor.withOpacity(0.7)
                          : AppConstants.textColor.withOpacity(0.7),
                      fontFamily: 'Public Sans',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildViewConnectionsButton(BuildContext context, bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/matches');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isDark ? 6 : 2,
        ),
        icon: const Icon(Icons.people, size: 20),
        label: const Text(
          'Ver Conexiones',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Public Sans',
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.blue.shade900.withOpacity(0.3)
            : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.blue.shade700.withOpacity(0.5)
              : Colors.blue.shade100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.blue.shade700.withOpacity(0.5)
                  : Colors.blue.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Nueva Capacitación Disponible',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.blue.shade200 : Colors.blue,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¡Inscríbete en el nuevo taller de "Comunicación Efectiva con Personas Mayores"! Mejora tus habilidades y gana más puntos.',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppConstants.hintColor : AppConstants.textColor,
              fontFamily: 'Public Sans',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Leer más',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.blue.shade300 : Colors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsProgress(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.backgroundDark.withOpacity(0.5)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppConstants.primaryColor.withOpacity(0.3)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Próxima Recompensa: Vale de Café',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppConstants.hintColor
                        : AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
              ),
              Text(
                '75/100',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryColor,
                  fontFamily: 'Public Sans',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Barra de progreso
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.75,
              child: Container(
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Puntos',
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppConstants.hintColor.withOpacity(0.7)
                  : AppConstants.textColor.withOpacity(0.7),
              fontFamily: 'Public Sans',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '¡Sigue así! Estás a solo 25 puntos de tu recompensa.',
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppConstants.hintColor.withOpacity(0.7)
                  : AppConstants.textColor.withOpacity(0.7),
              fontFamily: 'Public Sans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.assignment,
            title: 'Registrar\nSesión',
            color: isDark
                ? Colors.blue.shade900.withOpacity(0.3)
                : Colors.blue.shade50,
            iconColor: AppConstants.primaryColor,
            borderColor: isDark
                ? Colors.blue.shade700.withOpacity(0.5)
                : Colors.blue.shade200,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Funcionalidad de registrar sesión en desarrollo',
                  ),
                  backgroundColor: AppConstants.primaryColor,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.explore,
            title: 'Explorar\nActividades',
            color: AppConstants.primaryColor,
            iconColor: Colors.white,
            borderColor: AppConstants.primaryColor,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Funcionalidad de explorar actividades en desarrollo',
                  ),
                  backgroundColor: AppConstants.primaryColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: iconColor,
                  fontFamily: 'Public Sans',
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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
            onTap: () {},
            child: _buildNavItem(
              icon: Icons.home,
              label: 'Inicio',
              isActive: true,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/matches');
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
              Navigator.pushNamed(context, '/rewards');
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
              isActive: false,
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