import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class ContactProfileScreen extends StatelessWidget {
  final Map<String, dynamic> contact;
  
  const ContactProfileScreen({
    super.key,
    required this.contact,
  });

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
          'Perfil',
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
          children: [
            // Header del perfil
            _buildProfileHeader(context),
            
            const SizedBox(height: 32),
            
            // Botones de acción
            _buildActionButtons(context),
            
            const SizedBox(height: 32),
            
            // Sección "Sobre Elena"
            _buildAboutSection(),
            
            const SizedBox(height: 32),
            
            // Sección de Intereses
            _buildInterestsSection(),
            
            const SizedBox(height: 100), // Espacio para navegación inferior
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
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
                color: Colors.orange.shade100,
                border: Border.all(
                  color: AppConstants.primaryColor,
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.orange.shade700,
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
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Nombre
        Text(
          contact['name'] ?? 'Elena Ramírez',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),
        
        const SizedBox(height: 4),
        
        // Tipo de usuario
        Text(
          'Voluntaria',
          style: TextStyle(
            fontSize: 16,
            color: AppConstants.textColor.withOpacity(0.7),
            fontFamily: 'Public Sans',
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _startVideoCall(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppConstants.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: Icon(
              Icons.videocam,
              color: AppConstants.primaryColor,
              size: 20,
            ),
            label: Text(
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

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sobre Elena',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),
        
        const SizedBox(height: 12),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            contact['bio'] ?? 
            'Elena es una voluntaria apasionada por ayudar a los demás. Tiene experiencia en cuidado de personas mayores y disfruta de actividades como la lectura y la jardinería.',
            style: TextStyle(
              fontSize: 16,
              color: AppConstants.textColor,
              fontFamily: 'Public Sans',
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    final interests = contact['interests'] ?? ['Lectura', 'Jardinería', 'Cuidado de mayores'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Intereses',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
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
                color: AppConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppConstants.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                interest,
                style: TextStyle(
                  fontSize: 14,
                  color: AppConstants.primaryColor,
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

  void _startVideoCall(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Iniciar Videollamada',
          style: const TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        content: Text(
          '¿Deseas iniciar una videollamada con ${contact['name'] ?? 'Elena'}?',
          style: const TextStyle(fontFamily: 'Public Sans'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Iniciando videollamada con ${contact['name'] ?? 'Elena'}...'),
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
}