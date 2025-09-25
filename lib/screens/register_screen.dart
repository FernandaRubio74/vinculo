import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _nombreController = TextEditingController(text: 'Fernanda Rubio');
  final _correoController = TextEditingController(text: 'fernandarubio@gmail.com');
  final _fechaController = TextEditingController(text: '18/03/2006');
  final _telefonoController = TextEditingController(text: '(503) 4545-7878');
  final _passwordController = TextEditingController(text: '*******');
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.accentColor, // Color rojo de fondo
      body: Stack(
        children: [
          // Círculos decorativos de fondo
          Positioned(
            left: -263,
            top: 527,
            child: Opacity(
              opacity: 0.40,
              child: Container(
                width: 400.85,
                height: 400.85,
                decoration: const ShapeDecoration(
                  color: Color(0xFF968F82),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Positioned(
            right: -173,
            top: 219,
            child: Opacity(
              opacity: 0.40,
              child: Container(
                width: 400.85,
                height: 400.85,
                decoration: const ShapeDecoration(
                  color: Color(0xFF968F82),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          
          // Contenido principal
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  width: 343,
                  padding: const EdgeInsets.all(24),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ícono de flecha atrás
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 24,
                            height: 24,
                            child: const Icon(
                              Icons.arrow_back,
                              size: 20,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Header - Título y subtítulo
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 32,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.30,
                              letterSpacing: -0.64,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'Ya tienes una cuenta?',
                                style: TextStyle(
                                  color: Color(0xFF6C7278),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                  letterSpacing: -0.12,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  // Navegar a login
                                },
                                child: const Text(
                                  'Inicia Sesión',
                                  style: TextStyle(
                                    color: Color(0xFF4D81E7),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Formulario
                      Column(
                        children: [
                          // Campo Nombre Completo
                          _buildTextField(
                            label: 'Nombre Completo',
                            controller: _nombreController,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Campo Correo
                          _buildTextField(
                            label: 'Correo',
                            controller: _correoController,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Campo Fecha de Nacimiento
                          _buildTextField(
                            label: 'Fecha de Nacimiento',
                            controller: _fechaController,
                            suffixIcon: const Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Color(0xFF6C7278),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Campo Teléfono
                          _buildPhoneField(),
                          
                          const SizedBox(height: 16),
                          
                          // Campo Contraseña
                          _buildTextField(
                            label: 'Contraseña',
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              child: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                size: 16,
                                color: const Color(0xFF6C7278),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Botón Siguiente
                      Container(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () {
                            // Acción del botón
                            print('Siguiente pressed');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.accentColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Siguiente',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                  letterSpacing: -0.14,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6C7278),
            fontSize: 12,
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w500,
            height: 1.60,
            letterSpacing: -0.24,
          ),
        ),
        const SizedBox(height: 2),
        
        // Campo de texto
        Container(
          height: 46,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFEDF1F3),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(
              color: Color(0xFF1A1C1E),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1.40,
              letterSpacing: -0.14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12.5),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        const Text(
          'Teléfono',
          style: TextStyle(
            color: Color(0xFF6C7278),
            fontSize: 12,
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w500,
            height: 1.60,
            letterSpacing: -0.24,
          ),
        ),
        const SizedBox(height: 2),
        
        // Campo de teléfono con código de país
        Container(
          height: 46,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFEDF1F3),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3DE4E5E7),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              // Código de país
              Container(
                width: 62,
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12.5),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color(0xFFEDF1F3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bandera de El Salvador (puedes usar una imagen)
                    Container(
                      width: 18,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 12,
                      color: Color(0xFF6C7278),
                    ),
                  ],
                ),
              ),
              
              // Campo de número
              Expanded(
                child: TextFormField(
                  controller: _telefonoController,
                  style: const TextStyle(
                    color: Color(0xFF1A1C1E),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.14,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12.5),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _fechaController.dispose();
    _telefonoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
