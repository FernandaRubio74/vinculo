import 'package:flutter/material.dart';
import 'package:vinculo/utils/constants.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Controladores para la primera página
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _fechaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Controladores para la segunda página
  final _ciudadController = TextEditingController();
  final _institucionController = TextEditingController();
  final _nivelAcademicoController = TextEditingController();
  String? _selectedProfileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.accentColor,
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
                          onTap: () {
                            if (_currentPage == 0) {
                              Navigator.pop(context);
                            } else {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
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

                      // Indicador de progreso
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: _currentPage >= 0 ? AppConstants.accentColor : const Color(0xFFEDF1F3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: _currentPage >= 1 ? AppConstants.accentColor : const Color(0xFFEDF1F3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // PageView para las dos páginas
                      SizedBox(
                        height: 600,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          children: [
                            _buildFirstPage(),
                            _buildSecondPage(),
                          ],
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

  Widget _buildFirstPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

        // Formulario Primera Página
        Expanded(
          child: Column(
            children: [
              // Campo Nombre Completo
              _buildTextField(
                label: 'Nombre Completo',
                controller: _nombreController,
                hintText: 'Ingresa tu nombre completo',
              ),

              const SizedBox(height: 16),

              // Campo Correo
              _buildTextField(
                label: 'Correo',
                controller: _correoController,
                hintText: 'ejemplo@correo.com',
              ),

              const SizedBox(height: 16),

              // Campo Fecha de Nacimiento
              _buildTextField(
                label: 'Fecha de Nacimiento',
                controller: _fechaController,
                hintText: 'DD/MM/AAAA',
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
                hintText: 'Ingresa tu contraseña',
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

              const Spacer(),

              // Botón Siguiente
              Container(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateFirstPage()) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
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
      ],
    );
  }

  Widget _buildSecondPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header - Título
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

        const SizedBox(height: 24),

        // Formulario Segunda Página
        Expanded(
          child: Column(
            children: [
              // Campo Foto de perfil
              _buildSelectField(
                label: 'Foto de perfil',
                value: _selectedProfileImage ?? 'Seleccionar',
                onTap: () {
                  _selectProfileImage();
                },
                showIcon: true,
              ),

              const SizedBox(height: 16),

              // Campo Ciudad/Región
              _buildSelectField(
                label: 'Ciudad/Región',
                value: _ciudadController.text.isEmpty ? 'Seleccionar' : _ciudadController.text,
                onTap: () {
                  _selectCity();
                },
              ),

              const SizedBox(height: 16),

              // Campo Institución educativa
              _buildSelectField(
                label: 'Institución educativa (escuela/universidad)',
                value: _institucionController.text.isEmpty ? 'Seleccionar' : _institucionController.text,
                onTap: () {
                  _selectInstitution();
                },
              ),

              const SizedBox(height: 16),

              // Campo Nivel académico
              _buildSelectField(
                label: 'Nivel académico (secundaria/universidad/técnico)',
                value: _nivelAcademicoController.text.isEmpty ? 'Seleccionar' : _nivelAcademicoController.text,
                onTap: () {
                  _selectAcademicLevel();
                },
              ),

              const Spacer(),

              // Botón Siguiente
              Container(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateSecondPage()) {
                      _createAccount();
                    }
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
      ],
    );
  }

  Widget _buildSelectField({
    required String label,
    required String value,
    required VoidCallback onTap,
    bool showIcon = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Container(
          height: 21,
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
          child: Text(
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
        ),
        const SizedBox(height: 2),
        
        // Campo seleccionable
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12.5),
            clipBehavior: Clip.antiAlias,
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
                if (showIcon) ...[
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: value == 'Seleccionar' 
                          ? const Color(0xFF9CA3AF) 
                          : const Color(0xFF1A1C1E),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    int maxLines = 1,
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
          height: maxLines > 1 ? null : 46,
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
            maxLines: maxLines,
            style: const TextStyle(
              color: Color(0xFF1A1C1E),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 1.40,
              letterSpacing: -0.14,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: maxLines > 1 ? 12 : 12.5,
              ),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.40,
                letterSpacing: -0.14,
              ),
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
                    // Bandera de El Salvador
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
                    hintText: '0000-0000',
                    hintStyle: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                      letterSpacing: -0.14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _validateFirstPage() {
    if (_nombreController.text.isEmpty ||
        _correoController.text.isEmpty ||
        _fechaController.text.isEmpty ||
        _telefonoController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  bool _validateSecondPage() {
    if (_selectedProfileImage == null ||
        _ciudadController.text.isEmpty ||
        _institucionController.text.isEmpty ||
        _nivelAcademicoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  void _selectProfileImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Cámara'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedProfileImage = 'Imagen de cámara';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galería'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedProfileImage = 'Imagen de galería';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectCity() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Ciudad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('San Salvador'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _ciudadController.text = 'San Salvador';
                });
              },
            ),
            ListTile(
              title: const Text('Santa Ana'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _ciudadController.text = 'Santa Ana';
                });
              },
            ),
            ListTile(
              title: const Text('San Miguel'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _ciudadController.text = 'San Miguel';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectInstitution() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Institución'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Universidad de El Salvador'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _institucionController.text = 'Universidad de El Salvador';
                });
              },
            ),
            ListTile(
              title: const Text('Universidad Centroamericana'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _institucionController.text = 'Universidad Centroamericana';
                });
              },
            ),
            ListTile(
              title: const Text('Escuela Superior de Economía y Negocios'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _institucionController.text = 'Escuela Superior de Economía y Negocios';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectAcademicLevel() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Nivel Académico'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Secundaria'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _nivelAcademicoController.text = 'Secundaria';
                });
              },
            ),
            ListTile(
              title: const Text('Técnico'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _nivelAcademicoController.text = 'Técnico';
                });
              },
            ),
            ListTile(
              title: const Text('Universidad'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _nivelAcademicoController.text = 'Universidad';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createAccount() {
    print('Crear cuenta:');
    print('Nombre: ${_nombreController.text}');
    print('Correo: ${_correoController.text}');
    print('Fecha: ${_fechaController.text}');
    print('Teléfono: ${_telefonoController.text}');
    print('Foto: $_selectedProfileImage');
    print('Ciudad: ${_ciudadController.text}');
    print('Institución: ${_institucionController.text}');
    print('Nivel Académico: ${_nivelAcademicoController.text}');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cuenta creada exitosamente'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nombreController.dispose();
    _correoController.dispose();
    _fechaController.dispose();
    _telefonoController.dispose();
    _passwordController.dispose();
    _ciudadController.dispose();
    _institucionController.dispose();
    _nivelAcademicoController.dispose();
    super.dispose();
  }
}