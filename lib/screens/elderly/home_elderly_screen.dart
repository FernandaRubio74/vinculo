import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/config/providers/auth_provider.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/config/providers/matching_provider.dart'; 
import 'package:vinculo/config/providers/pending_connections_provider.dart'; 
import 'package:vinculo/config/providers/presentation/theme_provider.dart';


class HomeElderlyScreen extends ConsumerStatefulWidget {
  const HomeElderlyScreen({super.key});

  @override
  ConsumerState<HomeElderlyScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeElderlyScreen> {
  bool _hasNotifications = true;

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeNotifierProvider).isDarkMode;
    final suggestionsState = ref.watch(matchSuggestionsProvider);
    final currentUser = ref.watch(currentUserProvider);
    final pendingConnections = ref.watch(pendingConnectionsProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppConstants.backgroundDark
          : AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.largePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola de nuevo,',
                        style: TextStyle(
                          fontSize: 20,
                          color: isDark ? AppConstants.hintColor : AppConstants.textColor,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                      Text(
                        currentUser?.fullName.split(' ')[0] ?? 'Usuario', 
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppConstants.backgroundDark,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                    ],
                  ),
                  // ... (Botón de notificaciones)
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
                            decoration: const BoxDecoration(
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

              
                    Text(
                      'Solicitudes Pendientes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppConstants.backgroundDark,
                        fontFamily: 'Public Sans',
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    pendingConnections.when(
                      loading: () => const Center(heightFactor: 5, child: CircularProgressIndicator(color: AppConstants.primaryColor)),
                      error: (err, stack) => const Center(child: Text('Error al cargar solicitudes.')),
                      data: (requests) => _buildPendingRequestsList(ref, isDark, requests),
                    ),
                    const SizedBox(height: 24),


                    
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

                       
                        suggestionsState.when(
                          loading: () => const Center(
                            heightFactor: 10, 
                            child: CircularProgressIndicator(color: AppConstants.primaryColor)
                          ),
                          error: (err, stack) => Center(
                            child: Text('Error al cargar sugerencias: ${err.toString()}')
                          ),
                          data: (suggestions) {
                            if (suggestions.isEmpty) {
                              return const Center(
                                heightFactor: 10,
                                child: Text(
                                  'No hay nuevas sugerencias por ahora.\n¡Vuelve más tarde!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              );
                            }
                            
                            return Column(
                              children: suggestions
                                  .map((user) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: AppConstants.largePadding,
                                        ),
                                        child: _buildPersonCard(context, ref, user),
                                      ))
                                  .toList(),
                            );
                          }
                        ),
                      ],
                    ),

                    
                    const SizedBox(height: 100), 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context, isDark),
    );
  }

  
  Widget _buildPendingRequestsList(WidgetRef ref, bool isDark, List<PendingConnection> requests) {
    if (requests.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: isDark ? AppConstants.backgroundDark.withOpacity(0.5) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'No tienes solicitudes pendientes.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
        ),
      );
    }
    
    
    return Column(
      children: requests.map((request) => 
        _buildPendingCard(ref, isDark, request)
      ).toList(),
    );
  }

 
  Widget _buildPendingCard(WidgetRef ref, bool isDark, PendingConnection request) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? AppConstants.backgroundDark : Colors.white,
        borderRadius: BorderRadius.circular(16), 
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppConstants.backgroundDark, AppConstants.backgroundDark.withOpacity(0.8)]
              : [Colors.white, Colors.grey.shade50],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.primaryColor.withOpacity(0.2),
                  ),
                  child: const Icon(Icons.person, size: 24, color: AppConstants.primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.user.fullName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Quiere conectar contigo',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppConstants.hintColor : Colors.grey.shade700
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              request.user.bio ?? 'Sin biografía...',
              style: TextStyle(color: isDark ? AppConstants.hintColor : Colors.grey.shade800),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ref.read(pendingConnectionsProvider.notifier).rejectRequest(request.connectionId);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                  child: const Text('Rechazar'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    ref.read(pendingConnectionsProvider.notifier).acceptRequest(request.connectionId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Aceptar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  Widget _buildPersonCard(BuildContext context, WidgetRef ref, UserModel person) {
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
                  AppConstants.primaryColor.withOpacity(0.6),
                  AppConstants.primaryColor.withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
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
                      person.fullName, 
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
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: person.interests.map((interest) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            interest.icon, 
                            size: 16,
                            color: AppConstants.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            interest.name, 
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppConstants.primaryColor,
                              fontFamily: 'Public Sans',
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                Text(
                  person.bio ?? "Sin biografía disponible.",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppConstants.hintColor
                        : AppConstants.textColor,
                    fontFamily: 'Public Sans',
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
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
                onPressed: () => _connectWithPerson(context, ref, person),
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
                    Icon(Icons.phone, size: 20,),
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

  Widget _buildBottomNavigation(BuildContext context, bool isDark) {
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
                onTap: () => context.goNamed('elderly-profile'),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.local_activity,
                label: 'Actividades',
                isActive: false,
                onTap: () => context.goNamed('activities-elderly'),
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
    // ... (Tu código de NavItem se mantiene)
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
  }

  void _connectWithPerson(BuildContext context, WidgetRef ref, UserModel person) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Conectar con ${person.fullName}',
          style: const TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        content: Text(
          '¿Te gustaría enviar una solicitud de conexión a ${person.fullName}?',
          style: const TextStyle(
            fontFamily: 'Public Sans',
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
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
              ref.read(matchSuggestionsProvider.notifier)
                 .sendConnectionRequest(person.id);
              context.pop(); 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('¡Solicitud enviada a ${person.fullName}!'),
                  backgroundColor: AppConstants.primaryColor,
                ),
              );
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

  void _exploreActivities(BuildContext context) {
    context.goNamed('activities-elderly');
  }
}