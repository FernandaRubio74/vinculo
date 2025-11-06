import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';

class ContactProfileScreen extends ConsumerWidget {
  final Map<String, dynamic> contact;

  const ContactProfileScreen({
    super.key,
    required this.contact,
  });

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
          'Perfil',
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
          children: [
            // Header del perfil
            _buildProfileHeader(context, isDark),

            const SizedBox(height: 32),

            // Botones de acción
            _buildActionButtons(context, isDark),

            const SizedBox(height: 32),

            // Sección "Sobre Elena"
            _buildAboutSection(isDark),

            const SizedBox(height: 32),

            // Sección de Intereses
            _buildInterestsSection(isDark),

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
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? Colors.orange.shade800.withOpacity(0.3)
                    : Colors.orange.shade100,
                border: Border.all(
                  color: AppConstants.primaryColor,
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.person,
                size: 60,
                color: isDark
                    ? Colors.orange.shade300
                    : Colors.orange.shade700,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Nombre
        Text(
          contact['name'] ?? 'Elena Ramírez',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 4),

        // Tipo de usuario
        Text(
          'Voluntaria',
          style: TextStyle(
            fontSize: 16,
            color: isDark
                ? AppConstants.hintColor.withOpacity(0.7)
                : AppConstants.textColor.withOpacity(0.7),
            fontFamily: 'Public Sans',
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _startVideoCall(context, isDark),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppConstants.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: const Icon(
              Icons.videocam,
              color: AppConstants.primaryColor,
              size: 20,
            ),
            label: const Text(
              'Videollamada',
              style: TextStyle(
                color: AppConstants.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _sendMessage(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: isDark ? 6 : 2,
            ),
            icon: const Icon(Icons.message, size: 20),
            label: const Text(
              'Mensaje',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sobre Elena',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
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
          child: Text(
            contact['bio'] ??
                'Elena es una voluntaria apasionada por ayudar a los demás. Tiene experiencia en cuidado de personas mayores y disfruta de actividades como la lectura y la jardinería.',
            style: TextStyle(
              fontSize: 16,
              color: isDark
                  ? AppConstants.hintColor
                  : AppConstants.textColor,
              fontFamily: 'Public Sans',
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSection(bool isDark) {
    final interests = contact['interests'] ?? ['Lectura', 'Jardinería', 'Cuidado de mayores'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Intereses',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: interests.map<Widget>((interest) {
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
                interest,
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

  void _startVideoCall(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppConstants.backgroundDark
            : AppConstants.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Iniciar Videollamada',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        content: Text(
          '¿Deseas iniciar una videollamada con ${contact['name'] ?? 'Elena'}?',
          style: TextStyle(
            fontFamily: 'Public Sans',
            color: isDark ? AppConstants.hintColor : AppConstants.textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
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
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Iniciando videollamada con ${contact['name'] ?? 'Elena'}...'),
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

  void _sendMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Abriendo chat con ${contact['name'] ?? 'Elena'}...'),
        backgroundColor: AppConstants.primaryColor,
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
              isActive: true,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/volunteer/rewards'),
            child: _buildNavItem(
              icon: Icons.card_giftcard,
              label: 'Recompensas',
              isActive: false,
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