import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/screens/volunteer/contact_profile_screen.dart';

class MatchesScreen extends ConsumerWidget {
  const MatchesScreen({super.key});

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
          'Matches para ti',
          style: TextStyle(
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Public Sans',
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              _showFilterDialog(context, isDark);
            },
            icon: Icon(
              Icons.tune,
              color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        itemCount: _getMatchesData().length,
        itemBuilder: (context, index) {
          final match = _getMatchesData()[index];
          return _buildMatchCard(context, match, isDark);
        },
      ),
      bottomNavigationBar: _buildBottomNavigation(context, isDark),
    );
  }

  Widget _buildMatchCard(BuildContext context, Map<String, dynamic> match, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con foto, nombre y porcentaje de match
          Row(
            children: [
              // Avatar circular
              Container(
                width: 60,
                height: 60,
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
                  size: 30,
                  color: isDark
                      ? Colors.grey.shade400
                      : Colors.grey.shade600,
                ),
              ),

              const SizedBox(width: 12),

              // Información básica
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${match['name']}, ${match['age']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppConstants.hintColor
                            : AppConstants.textColor,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      match['location'],
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

              // Porcentaje de match
              Column(
                children: [
                  Text(
                    '${match['matchPercentage']}%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getMatchColor(match['matchPercentage']),
                      fontFamily: 'Public Sans',
                    ),
                  ),
                  Text(
                    'Match',
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
            ],
          ),

          const SizedBox(height: 16),

          // Intereses en común
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Intereses en común:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppConstants.hintColor
                      : AppConstants.textColor,
                  fontFamily: 'Public Sans',
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: (match['commonInterests'] as List<String>).map((
                  interest,
                ) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.blue.shade900.withOpacity(0.3)
                          : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? Colors.blue.shade700.withOpacity(0.5)
                            : Colors.blue.shade200,
                      ),
                    ),
                    child: Text(
                      interest,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.blue.shade300 : Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Disponibilidad
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Disponibilidad:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppConstants.hintColor
                      : AppConstants.textColor,
                  fontFamily: 'Public Sans',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                match['availability'],
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

          const SizedBox(height: 16),

          // Botones de acción
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _viewProfile(context, match),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppConstants.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Ver Perfil',
                    style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _callMatch(context, match, isDark),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: isDark ? 6 : 2,
                  ),
                  icon: const Icon(Icons.phone, size: 16),
                  label: const Text(
                    'Llamar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getMatchColor(int percentage) {
    if (percentage >= 90) return Colors.green;
    if (percentage >= 80) return Colors.blue;
    if (percentage >= 70) return Colors.orange;
    return Colors.grey;
  }

  void _viewProfile(BuildContext context, Map<String, dynamic> match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactProfileScreen(contact: match),
      ),
    );
  }

  void _callMatch(BuildContext context, Map<String, dynamic> match, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppConstants.backgroundDark
            : AppConstants.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Llamar a ${match['name']}',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
          ),
        ),
        content: Text(
          '¿Estás seguro de que quieres iniciar una videollamada?',
          style: TextStyle(
            fontFamily: 'Public Sans',
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: isDark
                    ? AppConstants.hintColor.withOpacity(0.7)
                    : Colors.grey,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Iniciando llamada con ${match['name']}...'),
                  backgroundColor: AppConstants.primaryColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
            ),
            child: const Text(
              'Llamar',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppConstants.backgroundDark
            : AppConstants.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Filtros',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
          ),
        ),
        content: Text(
          'Funcionalidad de filtros en desarrollo',
          style: TextStyle(
            fontFamily: 'Public Sans',
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
          ),
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
            onTap: () {},
            child: _buildNavItem(
              icon: Icons.people,
              label: 'Matches',
              isActive: true,
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

  List<Map<String, dynamic>> _getMatchesData() {
    return [
      {
        'name': 'Sofía',
        'age': 78,
        'location': 'Madrid',
        'matchPercentage': 92,
        'commonInterests': ['Lectura', 'Jardinería'],
        'availability': 'Lunes y Miércoles por la tarde',
      },
      {
        'name': 'Carlos',
        'age': 82,
        'location': 'Barcelona',
        'matchPercentage': 85,
        'commonInterests': ['Música clásica'],
        'availability': 'Fines de semana',
      },
      {
        'name': 'Elena',
        'age': 75,
        'location': 'Valencia',
        'matchPercentage': 78,
        'commonInterests': ['Cocina'],
        'availability': 'Martes por la mañana',
      },
    ];
  }
}