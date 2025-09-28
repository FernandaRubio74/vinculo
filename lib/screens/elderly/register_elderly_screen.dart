import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class RegisterElderlyScreen extends StatefulWidget {
  const RegisterElderlyScreen({super.key});

  @override
  State<RegisterElderlyScreen> createState() => _RegisterElderlyScreenState();
}

class _RegisterElderlyScreenState extends State<RegisterElderlyScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  
  // Lista de intereses disponibles
  final List<Interest> _interests = [
    Interest(
      id: 'reading',
      name: 'Lectura',
      icon: Icons.menu_book,
      color: Colors.brown,
    ),
    Interest(
      id: 'gardening',
      name: 'Jardinería',
      icon: Icons.local_florist,
      color: Colors.green,
    ),
    Interest(
      id: 'music',
      name: 'Música',
      icon: Icons.music_note,
      color: Colors.purple,
    ),
    Interest(
      id: 'cooking',
      name: 'Cocina',
      icon: Icons.restaurant,
      color: Colors.orange,
    ),
    Interest(
      id: 'art',
      name: 'Arte',
      icon: Icons.palette,
      color: Colors.pink,
    ),
    Interest(
      id: 'sports',
      name: 'Deportes',
      icon: Icons.sports_soccer,
      color: Colors.blue,
    ),
    Interest(
      id: 'travel',
      name: 'Viajes',
      icon: Icons.flight,
      color: Colors.teal,
    ),
    Interest(
      id: 'technology',
      name: 'Tecnología',
      icon: Icons.computer,
      color: Colors.indigo,
    ),
  ];
  
  Set<String> _selectedInterests = {};
  bool _hasProfilePhoto = false;

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Contenido principal scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                child: Column(
                  children: [
                    const SizedBox(height: AppConstants.defaultPadding),
                    
                    // Título y subtítulo
                    Column(
                      children: [
                        Text(
                          'Crea tu perfil',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),
                        Text(
                          'Cuéntanos un poco sobre ti.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: isDark ? AppConstants.backgroundColor : AppConstants.textColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Sección de foto de perfil
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _selectProfilePhoto,
                          child: Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark 
                                  ? AppConstants.textColor
                                  : Colors.grey.shade200,
                              border: _hasProfilePhoto
                                  ? Border.all(
                                      color: AppConstants.primaryColor,
                                      width: 3,
                                    )
                                  : null,
                            ),
                            child: _hasProfilePhoto
                                ? const Icon(
                                    Icons.person,
                                    size: 64,
                                    color: AppConstants.primaryColor,
                                  )
                                : Icon(
                                    Icons.add_a_photo,
                                    size: 48,
                                    color: isDark 
                                        ? AppConstants.textColor 
                                        : AppConstants.backgroundColor,
                                  ),
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),
                        Text(
                          'Añadir foto (opcional)',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? AppConstants.textColor : AppConstants.backgroundColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Campo de nombre
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: TextField(
                        controller: _nameController,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontFamily: 'Public Sans',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Tu nombre',
                          hintStyle: TextStyle(
                            color: isDark ? AppConstants.textColor : AppConstants.backgroundColor,
                            fontSize: 20,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDark ? AppConstants.textColor : AppConstants.backgroundColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDark ? AppConstants.textColor : AppConstants.backgroundColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppConstants.primaryColor,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Sección de intereses
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tus intereses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),
                        
                        // Grid de intereses
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppConstants.defaultPadding,
                            mainAxisSpacing: AppConstants.defaultPadding,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: _interests.length,
                          itemBuilder: (context, index) {
                            final interest = _interests[index];
                            final isSelected = _selectedInterests.contains(interest.id);
                            
                            return GestureDetector(
                              onTap: () => _toggleInterest(interest.id),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected 
                                        ? AppConstants.primaryColor
                                        : (isDark ? AppConstants.textColor : AppConstants.backgroundColor),
                                    width: isSelected ? 3 : 2,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppConstants.primaryColor.withOpacity(0.3),
                                            blurRadius: 8,
                                            spreadRadius: 0,
                                          ),
                                        ]
                                      : [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                ),
                                child: Stack(
                                  children: [
                                    // Contenido principal
                                    Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            interest.icon,
                                            size: 32,
                                            color: isSelected
                                                ? AppConstants.primaryColor
                                                : interest.color,
                                          ),
                                          const SizedBox(height: AppConstants.smallPadding),
                                          Text(
                                            interest.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: isSelected 
                                                  ? FontWeight.bold 
                                                  : FontWeight.w500,
                                              color: isSelected
                                                  ? AppConstants.primaryColor
                                                  : Theme.of(context).colorScheme.onSurface,
                                              fontFamily: 'Public Sans',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Icono de check cuando está seleccionado
                                    if (isSelected)
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: AppConstants.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Campo de descripción
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Algo sobre ti (opcional)',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: TextField(
                            controller: _bioController,
                            maxLines: 4,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontFamily: 'Public Sans',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Escribe aquí...',
                              hintStyle: TextStyle(
                                color: isDark ? AppConstants.textColor : AppConstants.backgroundColor,
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark ? AppConstants.textColor : AppConstants.backgroundColor,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark ? AppConstants.textColor : AppConstants.backgroundColor,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppConstants.primaryColor,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            
            // Botón "Siguiente" fijo en la parte inferior
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppConstants.largePadding,
                0,
                AppConstants.largePadding,
                MediaQuery.of(context).padding.bottom + AppConstants.defaultPadding,
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    shadowColor: AppConstants.primaryColor.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Terminar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleInterest(String interestId) {
    setState(() {
      if (_selectedInterests.contains(interestId)) {
        _selectedInterests.remove(interestId);
      } else {
        _selectedInterests.add(interestId);
      }
    });
  }

  void _selectProfilePhoto() {
    // Simular selección de foto
    setState(() {
      _hasProfilePhoto = !_hasProfilePhoto;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _hasProfilePhoto 
              ? 'Foto de perfil añadida' 
              : 'Foto de perfil eliminada',
        ),
        backgroundColor: AppConstants.primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleNext() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa tu nombre'),
          backgroundColor: AppConstants.accentColorLight,
        ),
      );
      return;
    }

    // Crear resumen del perfil
    final selectedInterestNames = _interests
        .where((interest) => _selectedInterests.contains(interest.id))
        .map((interest) => interest.name)
        .toList();

    _showSuccessScreen();
  }

  void _showSuccessScreen() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppConstants.backgroundColor
                : Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppConstants.primaryColor,
                        size: 100,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        '¡Registro Exitoso!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tu cuenta ha sido creada. ¡Qué alegría tenerte aquí! Ya estás listo para conectar con personas maravillosas.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[300]
                              : Colors.grey[700],
                          fontFamily: 'Public Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el modal
                    Navigator.pushReplacementNamed(context, '/home_elderly'); // <-- Cambia aquí la ruta
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    'Empezar a Conectar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clase para representar un interés
class Interest {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  Interest({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}