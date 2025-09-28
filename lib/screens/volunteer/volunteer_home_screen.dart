import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class VolunteerHomeScreen extends StatelessWidget {
  const VolunteerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'VínculoVital',
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Public Sans',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Acción de configuración
            },
            icon: const Icon(Icons.settings, color: AppConstants.textColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saludo personalizado
            const Text(
              '¡Hola, Sofía!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppConstants.textColor,
                fontFamily: 'Public Sans',
              ),
            ),

            const SizedBox(height: 24),

            // Sección de Conexiones Destacadas
            _buildSectionTitle('Conexiones Destacadas'),
            const SizedBox(height: 12),
            _buildFeaturedConnections(),

            // Botón "Ver Conexiones"
            const SizedBox(height: 16),
            _buildViewConnectionsButton(context),

            const SizedBox(height: 24),

            // Sección de Anuncios para Voluntarios
            _buildSectionTitle('Anuncios para Voluntarios'),
            const SizedBox(height: 12),
            _buildAnnouncementCard(),

            const SizedBox(height: 24),

            // Sección de Progreso de Recompensas
            _buildSectionTitle('Progreso de Recompensas'),
            const SizedBox(height: 12),
            _buildRewardsProgress(),

            const SizedBox(height: 24),

            // Acciones rápidas mejoradas
            _buildQuickActions(context),

            const SizedBox(height: 100), // Espacio para la navegación inferior
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppConstants.textColor,
        fontFamily: 'Public Sans',
      ),
    );
  }

  Widget _buildFeaturedConnections() {
    final connections = [
      {'name': 'Carlos', 'status': 'Próxima sesión:\nMañana'},
      {'name': 'Elena', 'status': 'Próxima sesión: 2 días'},
      {'name': 'Roberto', 'status': 'Próxima ses...'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: connections.length,
        itemBuilder: (context, index) {
          final connection = connections[index];
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
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
                const SizedBox(height: 8),
                // Nombre
                Text(
                  connection['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                // Estado
                Text(
                  connection['status']!,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppConstants.textColor.withOpacity(0.7),
                    fontFamily: 'Public Sans',
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Nuevo botón "Ver Conexiones"
  Widget _buildViewConnectionsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/matches');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
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

  Widget _buildAnnouncementCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Nueva Capacitación Disponible',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    fontFamily: 'Public Sans',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '¡Inscríbete en el nuevo taller de "Comunicación Efectiva con Personas Mayores"! Mejora tus habilidades y gana más puntos.',
            style: TextStyle(
              fontSize: 14,
              color: AppConstants.textColor,
              fontFamily: 'Public Sans',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // Acción de leer más
            },
            child: const Text(
              'Leer más',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsProgress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Próxima Recompensa: Vale de Café',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.textColor,
                  fontFamily: 'Public Sans',
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
          const SizedBox(height: 12),
          // Barra de progreso
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.75, // 75%
              child: Container(
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Puntos',
            style: TextStyle(
              fontSize: 12,
              color: AppConstants.textColor.withOpacity(0.7),
              fontFamily: 'Public Sans',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¡Sigue así! Estás a solo 25 puntos de tu recompensa.',
            style: TextStyle(
              fontSize: 12,
              color: AppConstants.textColor.withOpacity(0.7),
              fontFamily: 'Public Sans',
            ),
          ),
        ],
      ),
    );
  }

  // Acciones rápidas mejoradas según la imagen
  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.assignment,
            title: 'Registrar\nSesión',
            color: Colors.blue.shade50,
            iconColor: AppConstants.primaryColor,
            borderColor: Colors.blue.shade200,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: iconColor),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: iconColor,
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
              // Ya estamos en inicio, no hacer nada
            },
            child: _buildNavItem(
              icon: Icons.home,
              label: 'Inicio',
              isActive: true,
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
}
