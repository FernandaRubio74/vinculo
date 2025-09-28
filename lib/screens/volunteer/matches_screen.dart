import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/screens/volunteer/contact_profile_screen.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Matches para ti',
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Public Sans',
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              _showFilterDialog(context);
            },
            icon: const Icon(Icons.tune, color: AppConstants.textColor),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        itemCount: _getMatchesData().length,
        itemBuilder: (context, index) {
          final match = _getMatchesData()[index];
          return _buildMatchCard(context, match);
        },
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildMatchCard(BuildContext context, Map<String, dynamic> match) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                  color: Colors.grey.shade300,
                  border: Border.all(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.grey.shade600,
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textColor,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      match['location'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstants.textColor.withOpacity(0.7),
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
                      color: AppConstants.textColor.withOpacity(0.7),
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
              const Text(
                'Intereses en común:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.textColor,
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
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Text(
                      interest,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
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
              const Text(
                'Disponibilidad:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.textColor,
                  fontFamily: 'Public Sans',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                match['availability'],
                style: TextStyle(
                  fontSize: 14,
                  color: AppConstants.textColor.withOpacity(0.7),
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
                  onPressed: () => _callMatch(context, match),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
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

  void _callMatch(BuildContext context, Map<String, dynamic> match) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Llamar a ${match['name']}',
          style: const TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          '¿Estás seguro de que quieres iniciar una videollamada?',
          style: TextStyle(fontFamily: 'Public Sans'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey, fontFamily: 'Public Sans'),
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
              style: TextStyle(color: Colors.white, fontFamily: 'Public Sans'),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Filtros',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Funcionalidad de filtros en desarrollo',
              style: TextStyle(fontFamily: 'Public Sans'),
            ),
          ],
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

  // Navegación estandarizada: Inicio, Matches, Recompensas, Perfil
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
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
            ),
          ),
          GestureDetector(
            onTap: () {
              // Ya estamos en matches, no hacer nada
            },
            child: _buildNavItem(
              icon: Icons.people,
              label: 'Matches',
              isActive: true,
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
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive
              ? AppConstants.primaryColor
              : AppConstants.textColor.withOpacity(0.5),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive
                ? AppConstants.primaryColor
                : AppConstants.textColor.withOpacity(0.5),
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
