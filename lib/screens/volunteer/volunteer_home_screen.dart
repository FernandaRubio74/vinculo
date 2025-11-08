import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/config/providers/auth_provider.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/config/providers/active_connections_provider.dart'; 
import 'package:vinculo/config/providers/pending_connections_provider.dart';


class VolunteerHomeScreen extends ConsumerWidget {
  const VolunteerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeNotifierProvider).isDarkMode;
    final activeConnections = ref.watch(activeConnectionsProvider);
    final currentUser = ref.watch(currentUserProvider);
    final pendingConnections = ref.watch(pendingConnectionsProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppConstants.backgroundDark
          : AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('VínculoVital', style: TextStyle(color: isDark ? AppConstants.hintColor : AppConstants.textColor, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Public Sans',),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.pushNamed('settings'),
            icon: Icon(Icons.settings, color: isDark ? AppConstants.hintColor : AppConstants.textColor,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Hola, ${currentUser?.fullName.split(' ')[0] ?? 'Voluntario'}!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? AppConstants.hintColor : AppConstants.textColor,
                fontFamily: 'Public Sans',
              ),
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('Solicitudes Pendientes', isDark),
            const SizedBox(height: 12),
            pendingConnections.when(
              loading: () => const Center(child: CircularProgressIndicator(color: AppConstants.primaryColor)),
              error: (err, stack) => const Center(child: Text('Error al cargar solicitudes.')),
              data: (requests) => _buildPendingRequests(ref, isDark, requests),
            ),
            const SizedBox(height: 20),


            _buildSectionTitle('Conexiones Activas', isDark),
            const SizedBox(height: 12),
            activeConnections.when(
              loading: () => const Center(heightFactor: 3, child: CircularProgressIndicator(color: AppConstants.primaryColor)),
              error: (err, stack) => const Center(child: Text('No se pudieron cargar tus conexiones.')),
              data: (connections) => _buildFeaturedConnections(isDark, connections),
            ),

            const SizedBox(height: 16),
            _buildViewConnectionsButton(context, isDark),
            const SizedBox(height: 20),
            
            _buildSectionTitle('Anuncios para Voluntarios', isDark),
            const SizedBox(height: 12),
            _buildAnnouncementCard(isDark),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context, isDark),
    );
  }


  Widget _buildPendingRequests(WidgetRef ref, bool isDark, List<PendingConnection> requests) {
    if (requests.isEmpty) {
      return Container(
        height: 90,
        alignment: Alignment.center,
        child: Text(
          'No tienes solicitudes pendientes.',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }
    

    return SizedBox(
      height: 160, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return _buildPendingCard(ref, isDark, request);
        },
      ),
    );
  }


  Widget _buildPendingCard(WidgetRef ref, bool isDark, PendingConnection request) {
    return Container(
      width: 280, // Ancho de la tarjeta
      margin: const EdgeInsets.only(right: 12),
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
            const Spacer(), 

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



  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: isDark ? AppConstants.hintColor : AppConstants.textColor,
        fontFamily: 'Public Sans',
      ),
    );
  }

  Widget _buildFeaturedConnections(bool isDark, List<UserModel> connections) {
    if (connections.isEmpty) {
      return Container(
        height: 90,
        alignment: Alignment.center,
        child: Text(
          'Aún no tienes conexiones activas.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }
    
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: connections.length,
        itemBuilder: (context, index) {
          final user = connections[index];
          return Container(
            width: 85,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    border: Border.all(color: AppConstants.primaryColor, width: 2,),
                  ),
                  child: Icon(Icons.person, size: 25, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,),
                ),
                const SizedBox(height: 6),
                Text(
                  user.fullName.split(' ')[0], 
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppConstants.hintColor : AppConstants.textColor,
                    fontFamily: 'Public Sans',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Flexible(
                  child: Text(
                    'Conectado', 
                    style: TextStyle(
                      fontSize: 9,
                      color: isDark
                          ? AppConstants.hintColor.withOpacity(0.7)
                          : AppConstants.textColor.withOpacity(0.7),
                      fontFamily: 'Public Sans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildViewConnectionsButton(BuildContext context, bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.goNamed('matches');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: isDark ? 6 : 2,
        ),
        icon: const Icon(Icons.people, size: 20),
        label: const Text(
          'Buscar Nuevos Matches', 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Public Sans',
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.blue.shade900.withOpacity(0.3)
            : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.blue.shade700.withOpacity(0.5)
              : Colors.blue.shade100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.blue.shade700.withOpacity(0.5)
                  : Colors.blue.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Nueva Capacitación Disponible',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.blue.shade200 : Colors.blue,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¡Inscríbete en el nuevo taller de "Comunicación Efectiva con Personas Mayores"! Mejora tus habilidades y gana más puntos.',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppConstants.hintColor : AppConstants.textColor,
              fontFamily: 'Public Sans',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Leer más',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.blue.shade300 : Colors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Public Sans',
              ),
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
            onTap: () {}, 
            child: _buildNavItem(
              icon: Icons.home,
              label: 'Inicio',
              isActive: true,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.goNamed('matches');
            },
            child: _buildNavItem(
              icon: Icons.people,
              label: 'Matches',
              isActive: false,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.goNamed('rewards');
            },
            child: _buildNavItem(
              icon: Icons.card_giftcard,
              label: 'Recompensas',
              isActive: false,
              isDark: isDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.goNamed('volunteer-profile');
            },
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