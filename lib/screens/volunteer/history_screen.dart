import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppConstants.textColor,
          ),
        ),
        title: const Text(
          'Historial',
          style: TextStyle(
            color: AppConstants.textColor,
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
            _buildSummarySection(),
            
            const SizedBox(height: 32),
            
            // Sección de Videollamadas
            _buildVideoCallsSection(),
            
            const SizedBox(height: 32),
            
            // Sección de Otras Interacciones
            _buildOtherInteractionsSection(),
            
            const SizedBox(height: 100), // Espacio para navegación inferior
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Resumen',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
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
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildSummaryCard(
                title: 'Horas de\nVoluntariado',
                value: '32',
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
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: AppConstants.textColor.withOpacity(0.7),
            fontFamily: 'Public Sans',
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCallsSection() {
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
        const Text(
          'Videollamadas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),
        
        const SizedBox(height: 16),
        
        ...videoCalls.map((call) => _buildVideoCallCard(call)),
      ],
    );
  }

  Widget _buildVideoCallCard(Map<String, String> call) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              color: AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${call['date']} • ${call['duration']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppConstants.textColor.withOpacity(0.7),
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

  Widget _buildOtherInteractionsSection() {
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
        const Text(
          'Otras Interacciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),
        
        const SizedBox(height: 16),
        
        ...interactions.map((interaction) => _buildInteractionCard(interaction)),
      ],
    );
  }

  Widget _buildInteractionCard(Map<String, dynamic> interaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              color: AppConstants.primaryColor.withOpacity(0.1),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  interaction['date'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppConstants.textColor.withOpacity(0.7),
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

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
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
              Navigator.pushReplacementNamed(context, '/matches');
            },
            child: _buildNavItem(
              icon: Icons.people,
              label: 'Matches',
              isActive: false,
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
              isActive: true,
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
}