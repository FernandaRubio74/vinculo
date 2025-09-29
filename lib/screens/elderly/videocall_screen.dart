import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vinculo/utils/constants.dart';

class VideoCallScreen extends StatefulWidget {
  final String contactName;
  
  const VideoCallScreen({
    super.key,
    this.contactName = 'Ana López',
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    // Ocultar la barra de estado
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    // Restaurar la barra de estado
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101c22),
      body: Stack(
        children: [
          // Video de fondo principal (simulado con gradiente)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppConstants.primaryColor.withOpacity(0.3),
                  const Color(0xFF101c22),
                  AppConstants.secondaryColor.withOpacity(0.5),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 200,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          
          // Overlay oscuro
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
          
          // Video propio (esquina superior derecha)
          Positioned(
            top: 60,
            right: 16,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showControls = !_showControls;
                });
              },
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppConstants.primaryColor.withOpacity(0.6),
                      AppConstants.secondaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: _isVideoOff
                    ? const Icon(
                        Icons.videocam_off,
                        color: Colors.white,
                        size: 40,
                      )
                    : const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 60,
                      ),
              ),
            ),
          ),
          
          // Controles de video (parte inferior)
          if (_showControls)
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largePadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botón silenciar
                    _buildControlButton(
                      icon: _isMuted ? Icons.mic_off : Icons.mic,
                      label: _isMuted ? 'Activar' : 'Silenciar',
                      onPressed: () {
                        setState(() {
                          _isMuted = !_isMuted;
                        });
                        HapticFeedback.lightImpact();
                      },
                      isActive: _isMuted,
                    ),
                    
                    // Botón video
                    _buildControlButton(
                      icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                      label: _isVideoOff ? 'Activar' : 'Detener',
                      onPressed: () {
                        setState(() {
                          _isVideoOff = !_isVideoOff;
                        });
                        HapticFeedback.lightImpact();
                      },
                      isActive: _isVideoOff,
                    ),
                    
                    // Botón finalizar (más grande)
                    _buildControlButton(
                      icon: Icons.call_end,
                      label: 'Finalizar',
                      onPressed: _endCall,
                      isEndCall: true,
                    ),
                  ],
                ),
              ),
            ),
            
          // Información del contacto (parte superior)
          if (_showControls)
            Positioned(
              top: 60,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Llamando a ${widget.contactName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Public Sans',
                  ),
                ),
              ),
            ),
        ],
      ),
      
      // Bottom Navigation (semi-transparente)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF101c22).withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.home,
                      label: 'Inicio',
                      onTap: () => _exitCall('/home'),
                    ),
                    _buildNavItem(
                      icon: Icons.person,
                      label: 'Perfil',
                      onTap: () => _exitCall('/profile'),
                    ),
                    _buildNavItem(
                      icon: Icons.local_activity,
                      label: 'Actividades',
                      onTap: () => _exitCall('/activities'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
    bool isEndCall = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isEndCall ? 80 : 64,
            height: isEndCall ? 80 : 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEndCall
                  ? AppConstants.accentColorLight
                  : Colors.white.withOpacity(0.3),
              border: isActive
                  ? Border.all(
                      color: AppConstants.primaryColor,
                      width: 2,
                    )
                  : null,
            ),
            child: Icon(
              icon,
              size: isEndCall ? 32 : 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Public Sans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppConstants.hintColor.withOpacity(0.5),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppConstants.hintColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontFamily: 'Public Sans',
            ),
          ),
        ],
      ),
    );
  }

  void _endCall() {
    HapticFeedback.mediumImpact();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Finalizar llamada',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.accentColorLight,
          ),
        ),
        content: Text(
          '¿Estás seguro de que deseas finalizar la llamada con ${widget.contactName}?',
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
                color: AppConstants.primaryColor,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar dialog
              Navigator.of(context).pop(); // Volver a la pantalla anterior
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.accentColorLight,
            ),
            child: const Text(
              'Finalizar',
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

  void _exitCall(String route) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Salir de la llamada',
          style: TextStyle(
            fontFamily: 'Public Sans',
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        content: const Text(
          'Si navegas a otra pantalla, la llamada se mantendrá en segundo plano.',
          style: TextStyle(
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
                color: AppConstants.primaryColor,
                fontFamily: 'Public Sans',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar dialog
              Navigator.pushReplacementNamed(context, route);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
            ),
            child: const Text(
              'Continuar',
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
}