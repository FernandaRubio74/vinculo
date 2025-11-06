import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

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
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
          ),
        ),
        title: Text(
          'Recompensas',
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
            // Sección de Beneficios
            _buildSectionTitle('Beneficios', isDark),
            const SizedBox(height: 16),
            _buildBenefitsSection(isDark),

            const SizedBox(height: 32),

            // Sección de Certificados Disponibles
            _buildSectionTitle('Certificados Disponibles', isDark),
            const SizedBox(height: 16),
            _buildCertificatesSection(context, isDark),

            const SizedBox(height: 32),

            // Sección de Mi Progreso
            _buildSectionTitle('Mi Progreso', isDark),
            const SizedBox(height: 16),
            _buildProgressSection(isDark),

            const SizedBox(height: 100), // Espacio para navegación inferior
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
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isDark ? AppConstants.hintColor : AppConstants.textColor,
        fontFamily: 'Public Sans',
      ),
    );
  }

  Widget _buildBenefitsSection(bool isDark) {
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
      children: benefits.map((benefit) => _buildBenefitCard(benefit, isDark)).toList(),
    );
  }

  Widget _buildBenefitCard(Map<String, dynamic> benefit, bool isDark) {
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
          // Icono
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (benefit['color'] as Color).withOpacity(isDark ? 0.3 : 0.1),
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
                  benefit['description'],
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

  Widget _buildCertificatesSection(BuildContext context, bool isDark) {
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
          .map((cert) => _buildCertificateCard(context, cert, isDark))
          .toList(),
    );
  }

  Widget _buildCertificateCard(
    BuildContext context,
    Map<String, dynamic> certificate,
    bool isDark,
  ) {
    final bool isAvailable = certificate['available'] as bool;
    final int currentHours = certificate['currentHours'] as int;
    final int requiredHours = certificate['hours'] as int;

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
          // Icono de certificado
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isAvailable
                  ? (isDark
                      ? Colors.green.withOpacity(0.3)
                      : Colors.green.withOpacity(0.1))
                  : (isDark
                      ? Colors.grey.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.1)),
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
                  certificate['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppConstants.hintColor.withOpacity(0.7)
                        : AppConstants.textColor.withOpacity(0.7),
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
                      color: isDark
                          ? Colors.green.withOpacity(0.3)
                          : Colors.green.withOpacity(0.1),
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
                      color: isDark
                          ? AppConstants.hintColor.withOpacity(0.5)
                          : AppConstants.textColor.withOpacity(0.5),
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
                  _downloadCertificate(context, certificate['title'], isDark),
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
                elevation: isDark ? 6 : 2,
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

  Widget _buildProgressSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  title: 'Certificados Obtenidos',
                  value: '1',
                  color: Colors.green,
                  isDark: isDark,
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
                  Text(
                    'Progreso para el próximo certificado',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppConstants.hintColor
                          : AppConstants.textColor,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                  const Text(
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
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
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
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(12),
        border: isDark
            ? Border.all(
                color: color.withOpacity(0.4),
                width: 1,
              )
            : null,
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

  void _downloadCertificate(BuildContext context, String certificateTitle, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppConstants.backgroundDark
            : AppConstants.backgroundColor,
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
          style: TextStyle(
            fontFamily: 'Public Sans',
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => context.pop(),
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
            onTap: () => context.go('/volunteer/home'),
            child: _buildNavItem(
              icon: Icons.home,
              label: 'Inicio',
              isActive: false,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/volunteer/matches'),
            child: _buildNavItem(
              icon: Icons.people,
              label: 'Matches',
              isActive: false,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: _buildNavItem(
              icon: Icons.card_giftcard,
              label: 'Recompensas',
              isActive: true,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/volunteer/profile'),
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