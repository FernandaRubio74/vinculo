import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class HomeElderlyScreen extends StatefulWidget {
  final String userName;

  const HomeElderlyScreen({
    super.key,
    this.userName = 'Elena',
  });

  @override
  State<HomeElderlyScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeElderlyScreen> {
  bool _hasNotifications = true;

  final List<PersonProfile> _availablePeople = [
    PersonProfile(
      name: 'Sofía',
      age: 23,
      description: 'A Sofía le encanta tocar la guitarra y visitar museos de arte. También es voluntaria en un refugio de animales.',
      interests: [
        Interest(name: 'Música', icon: Icons.music_note, isPrimary: true),
        Interest(name: 'Arte', icon: Icons.brush, isPrimary: false),
        Interest(name: 'Animales', icon: Icons.pets, isPrimary: false),
      ],
      avatar: Icons.person,
      color: AppConstants.primaryColor,
    ),
    PersonProfile(
      name: 'Ana',
      age: 25,
      description: 'Ana disfruta probando nuevas recetas, dando largos paseos por el parque y leyendo novelas históricas.',
      interests: [
        Interest(name: 'Cocina', icon: Icons.restaurant_menu, isPrimary: true),
        Interest(name: 'Naturaleza', icon: Icons.park, isPrimary: false),
        Interest(name: 'Lectura', icon: Icons.book, isPrimary: false),
      ],
      avatar: Icons.person,
      color: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppConstants.backgroundDark
          : AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header fijo
            Container(
              padding: const EdgeInsets.all(AppConstants.largePadding),
              decoration: BoxDecoration(
                color: (isDark
                        ? AppConstants.backgroundDark
                        : AppConstants.backgroundColor)
                    .withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Saludo personalizado
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola de nuevo,',
                        style: TextStyle(
                          fontSize: 20,
                          color: isDark
                              ? AppConstants.hintColor
                              : AppConstants.textColor,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                      Text(
                        widget.userName,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : AppConstants.backgroundDark,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                    ],
                  ),

                  // Botón de notificaciones
                  Stack(
                    children: [
                      IconButton(
                        onPressed: _handleNotifications,
                        icon: Icon(
                          Icons.notifications,
                          size: 30,
                          color: isDark
                              ? AppConstants.hintColor
                              : AppConstants.textColor,
                        ),
                      ),
                      if (_hasNotifications)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Contenido principal scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largePadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppConstants.defaultPadding),

                    // Sección "Conecta con alguien hoy"
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conecta con alguien hoy',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.white
                                : AppConstants.backgroundDark,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),

                        // Lista de personas (vertical en lugar de grid)
                        Column(
                          children: _availablePeople
                              .map((person) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppConstants.largePadding,
                                    ),
                                    child: _buildPersonCard(context, person),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),

                    // Sección "Explora Actividades"
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppConstants.largePadding),
                      decoration: BoxDecoration(
                         color: const Color(0xFFff9800).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Explora Actividades',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? Colors.white
                                        : AppConstants.backgroundDark,
                                    fontFamily: 'Public Sans',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Descubre eventos y grupos cerca de ti.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDark
                                        ? AppConstants.hintColor
                                        : AppConstants.textColor,
                                    fontFamily: 'Public Sans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppConstants.defaultPadding),
                          ElevatedButton(
                            onPressed: _exploreActivities,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFff9800),
                              foregroundColor: Colors.white,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(12),
                              elevation: 4,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100), // Espacio para la navegación
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildPersonCard(BuildContext context, PersonProfile person) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.backgroundDark
            : AppConstants.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de perfil con gradiente y nombre
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  person.color.withOpacity(0.6),
                  person.color.withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Icono de persona centrado
                Center(
                  child: Icon(
                    person.avatar,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                // Gradiente inferior con nombre
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Text(
                      '${person.name}, ${person.age}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contenido de la card
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags de intereses
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: person.interests.map((interest) {
                    final isPrimary = interest.isPrimary;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isPrimary
                            ? AppConstants.primaryColor.withOpacity(0.1)
                            : (isDark
                                ? AppConstants.backgroundDark
                                : AppConstants.hintColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            interest.icon,
                            size: 16,
                            color: isPrimary
                                ? AppConstants.primaryColor
                                : (isDark
                                    ? AppConstants.hintColor
                                    : AppConstants.textColor),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            interest.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isPrimary
                                  ? AppConstants.primaryColor
                                  : (isDark
                                      ? AppConstants.hintColor
                                      : AppConstants.textColor),
                              fontFamily: 'Public Sans',
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppConstants.defaultPadding),

                // Descripción
                Text(
                  person.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppConstants.hintColor
                        : AppConstants.textColor,
                    fontFamily: 'Public Sans',
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Botón conectar
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.defaultPadding,
              0,
              AppConstants.defaultPadding,
              AppConstants.defaultPadding,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _connectWithPerson(person),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 2,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Conectar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: (isDark
                ? AppConstants.backgroundDark
                : AppConstants.backgroundColor)
            .withOpacity(0.95),
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.grey.shade700.withOpacity(0.5)
                : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                icon: Icons.home,
                label: 'Inicio',
                isActive: true,
                onTap: () {},
              ),
              _buildNavItem(
                context: context,
                icon: Icons.person_outline,
                label: 'Perfil',
                isActive: false,
                onTap: () => Navigator.pushNamed(context, '/profile_elderly'),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.local_activity,
                label: 'Actividades',
                isActive: false,
                onTap: () => Navigator.pushNamed(context, '/activities_elderly'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive
                ? AppConstants.primaryColor
                : (isDark
                    ? AppConstants.hintColor
                    : AppConstants.textColor),
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
                      ? AppConstants.hintColor
                      : AppConstants.textColor),
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              fontFamily: 'Public Sans',
            ),
          ),
        ],
      ),
    );
  }

  void _handleNotifications() {
    setState(() {
      _hasNotifications = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notificaciones revisadas'),
        backgroundColor: AppConstants.primaryColor,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _connectWithPerson(PersonProfile person) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Conectar con ${person.name}',
          style: const TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        content: Text(
          '¿Te gustaría conectar con ${person.name}?',
          style: const TextStyle(
            fontFamily: 'Public Sans',
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppConstants.hintColor
                    : AppConstants.textColor,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/videocall');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
            ),
            child: const Text(
              'Aceptar',
              style: TextStyle(
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _exploreActivities() {
    Navigator.pushNamed(context, '/activities_elderly');
  }
}

// Clases para representar los datos
class PersonProfile {
  final String name;
  final int age;
  final String description;
  final List<Interest> interests;
  final IconData avatar;
  final Color color;

  PersonProfile({
    required this.name,
    required this.age,
    required this.description,
    required this.interests,
    required this.avatar,
    required this.color,
  });
}

class Interest {
  final String name;
  final IconData icon;
  final bool isPrimary;

  Interest({
    required this.name,
    required this.icon,
    required this.isPrimary,
  });
}