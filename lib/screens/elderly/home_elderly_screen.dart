import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class HomeElderlyScreen extends StatefulWidget {
  final String userName;
  
  const HomeElderlyScreen({
    super.key,
    this.userName = 'Carlos',
  });

  @override
  State<HomeElderlyScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeElderlyScreen> {
  bool _hasNotifications = true;
  
  // Lista de personas disponibles para conectar
  final List<Person> _availablePeople = [
    Person(
      name: 'Sofía',
      interest: 'Le gusta la música',
      avatar: Icons.person,
      color: Colors.purple,
    ),
    Person(
      name: 'Ana',
      interest: 'Le gusta la cocina',
      avatar: Icons.person,
      color: Colors.orange,
    ),
    Person(
      name: 'Miguel',
      interest: 'Le gusta la jardinería',
      avatar: Icons.person,
      color: Colors.green,
    ),
    Person(
      name: 'Elena',
      interest: 'Le gusta la lectura',
      avatar: Icons.person,
      color: Colors.brown,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header fijo
            Container(
              padding: const EdgeInsets.all(AppConstants.largePadding),
              decoration: BoxDecoration(
                color: (isDark 
                    ? AppConstants.backgroundColor
                    : AppConstants.primaryColor).withOpacity(0.9),
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
                          color: AppConstants.textColor,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                      Text(
                        widget.userName,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
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
                          color: AppConstants.textColor,
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
                              color: AppConstants.accentColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppConstants.backgroundColor,
                                width: 2,
                              ),
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
                            color: Theme.of(context).colorScheme.onBackground,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),
                        
                        // Grid de personas
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppConstants.defaultPadding,
                            mainAxisSpacing: AppConstants.defaultPadding,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: _availablePeople.length,
                          itemBuilder: (context, index) {
                            final person = _availablePeople[index];
                            return _buildPersonCard(context, person);
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.largePadding),
                    
                    // Sección "Explora Actividades"
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppConstants.largePadding),
                      decoration: BoxDecoration(
                        color: AppConstants.accentColor.withOpacity(0.2),
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
                                    color: Theme.of(context).colorScheme.onBackground,
                                    fontFamily: 'Public Sans',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Descubre eventos y grupos cerca de ti.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppConstants.textColor,
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
                              backgroundColor: AppConstants.accentColor,
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
                    
                    const SizedBox(height: AppConstants.largePadding),
                    
                    // Sección adicional - Actividades recientes
                    _buildRecentActivitiesSection(context),
                    
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

  Widget _buildPersonCard(BuildContext context, Person person) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: person.color.withOpacity(0.2),
              ),
              child: Icon(
                person.avatar,
                size: 40,
                color: person.color,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Información de la persona
            Expanded(
              child: Column(
                children: [
                  Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    person.interest,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppConstants.textColor,
                      fontFamily: 'Public Sans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Botón conectar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _connectWithPerson(person),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                  foregroundColor: AppConstants.primaryColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Conectar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitiesSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actividades Recientes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
            fontFamily: 'Public Sans',
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        
        // Lista de actividades
        Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
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
            children: [
              _buildActivityItem(
                context,
                'Llamada con Ana',
                'Hace 2 horas',
                Icons.call,
                AppConstants.primaryColor,
              ),
              const Divider(),
              _buildActivityItem(
                context,
                'Evento de jardinería',
                'Ayer',
                Icons.local_florist,
                Colors.green,
              ),
              const Divider(),
              _buildActivityItem(
                context,
                'Mensaje de Sofía',
                'Hace 3 días',
                Icons.message,
                Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'Public Sans',
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppConstants.textColor,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.textColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
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
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.local_activity,
                label: 'Actividades',
                isActive: false,
                onTap: () => Navigator.pushNamed(context, '/activities'),
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
                : AppConstants.textColor.withOpacity( 0.5),
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

  void _connectWithPerson(Person person) {
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
          '¿Te gustaría iniciar una conversación con ${person.name}?',
          style: const TextStyle(
            fontFamily: 'Public Sans',
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: AppConstants.accentColorLight,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Conectando con ${person.name}...'),
                  backgroundColor: AppConstants.primaryColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
            ),
            child: const Text(
              'Conectar',
              style: TextStyle(
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _exploreActivities() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegando a actividades...'),
        backgroundColor: AppConstants.accentColor,
      ),
    );
  }
}

// Clase para representar una persona
class Person {
  final String name;
  final String interest;
  final IconData avatar;
  final Color color;

  Person({
    required this.name,
    required this.interest,
    required this.avatar,
    required this.color,
  });
}