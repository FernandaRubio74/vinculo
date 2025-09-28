import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppConstants.textColor),
        ),
        title: const Text(
          'Recompensas',
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
            // Sección de Beneficios
            _buildSectionTitle('Beneficios'),
            const SizedBox(height: 16),
            _buildBenefitsSection(),

            const SizedBox(height: 32),

            // Sección de Certificados Disponibles
            _buildSectionTitle('Certificados Disponibles'),
            const SizedBox(height: 16),
            _buildCertificatesSection(context), // CORREGIDO: Pasar context

            const SizedBox(height: 32),

            // Sección de Mi Progreso
            _buildSectionTitle('Mi Progreso'),
            const SizedBox(height: 16),
            _buildProgressSection(),

            const SizedBox(height: 100), // Espacio para navegación inferior
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
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppConstants.textColor,
        fontFamily: 'Public Sans',
      ),
    );
  }

  Widget _buildBenefitsSection() {
    final benefits = [
      {
        'title': 'Certificados Académicos',
        'description':
            'Obtén certificados reconocidos por instituciones educativas.',
        'icon': Icons.school,
        'color': Colors.amber,
      },
      {
        'title': 'Reconocimiento en la Comunidad',
        'description':
            'Participa en eventos y recibe reconocimientos por tu labor.',
        'icon': Icons.people,
        'color': Colors.blue,
      },
      {
        'title': 'Desarrollo Personal',
        'description': 'Adquiere nuevas habilidades y experiencias valiosas.',
        'icon': Icons.psychology,
        'color': Colors.green,
      },
    ];

    return Column(
      children: benefits.map((benefit) => _buildBenefitCard(benefit)).toList(),
    );
  }

  Widget _buildBenefitCard(Map<String, dynamic> benefit) {
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
          // Icono
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (benefit['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(benefit['icon'], color: benefit['color'], size: 24),
          ),

          const SizedBox(width: 16),

          // Contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  benefit['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  benefit['description'],
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

  // CORREGIDO: Método que recibe context como parámetro
  Widget _buildCertificatesSection(BuildContext context) {
    final certificates = [
      {
        'title': 'Certificado de Voluntariado Social',
        'description': 'Reconocimiento por 50 horas de voluntariado.',
        'hours': 50,
        'currentHours': 75,
        'available': true,
      },
      {
        'title': 'Certificado de Liderazgo Juvenil',
        'description':
            'Reconocimiento por 100 horas de voluntariado en proyectos.',
        'hours': 100,
        'currentHours': 75,
        'available': false,
      },
    ];

    return Column(
      children: certificates
          .map((cert) => _buildCertificateCard(context, cert))
          .toList(),
    );
  }

  // CORREGIDO: Método que recibe context como parámetro
  Widget _buildCertificateCard(
    BuildContext context,
    Map<String, dynamic> certificate,
  ) {
    final bool isAvailable = certificate['available'] as bool;
    final int currentHours = certificate['currentHours'] as int;
    final int requiredHours = certificate['hours'] as int;

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
          // Icono de certificado
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isAvailable
                  ? Colors.green.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.workspace_premium,
              color: isAvailable ? Colors.green : Colors.grey,
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  certificate['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  certificate['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppConstants.textColor.withOpacity(0.7),
                    fontFamily: 'Public Sans',
                  ),
                ),
                const SizedBox(height: 8),
                if (isAvailable)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Disponible',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                  )
                else
                  Text(
                    '$currentHours/$requiredHours horas',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppConstants.textColor.withOpacity(0.5),
                      fontFamily: 'Public Sans',
                    ),
                  ),
              ],
            ),
          ),

          // Botón de acción
          if (isAvailable)
            ElevatedButton(
              onPressed: () =>
                  _downloadCertificate(context, certificate['title']),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: const Text(
                'Descargar',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Public Sans',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          // Estadísticas
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Horas de Voluntariado',
                  value: '75',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  title: 'Certificados Obtenidos',
                  value: '1',
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Progreso hacia el próximo certificado
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progreso para el próximo certificado',
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
                '25 horas restantes',
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
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Public Sans',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
              fontFamily: 'Public Sans',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // CORREGIDO: Método que recibe context como parámetro
  void _downloadCertificate(BuildContext context, String certificateTitle) {
    // Simular descarga de certificado
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Certificado Descargado',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        content: Text(
          'Tu $certificateTitle ha sido descargado exitosamente.',
          style: const TextStyle(fontFamily: 'Public Sans'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
            ),
            child: const Text(
              'Entendido',
              style: TextStyle(color: Colors.white, fontFamily: 'Public Sans'),
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
              // Ya estamos en recompensas, no hacer nada
            },
            child: _buildNavItem(
              icon: Icons.card_giftcard,
              label: 'Recompensas',
              isActive: true,
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
