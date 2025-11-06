import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ← NUEVO IMPORT
import 'package:vinculo/utils/constants.dart';

class RegisterVolunteerScreen extends StatefulWidget {
  const RegisterVolunteerScreen({super.key});

  @override
  State<RegisterVolunteerScreen> createState() => _RegisterVolunteerScreenState();
}

class _RegisterVolunteerScreenState extends State<RegisterVolunteerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  
  // Lista de intereses disponibles
  final List<Interest> _interests = [
    Interest(id: 'music', name: 'Música', color: Colors.blue),
    Interest(id: 'reading', name: 'Lectura', color: Colors.brown),
    Interest(id: 'gardening', name: 'Jardinería', color: Colors.green),
    Interest(id: 'cooking', name: 'Cocina', color: Colors.orange),
    Interest(id: 'art', name: 'Arte', color: Colors.pink),
    Interest(id: 'technology', name: 'Tecnología', color: Colors.indigo),
  ];

  // Lista de habilidades disponibles
  final List<Skill> _skills = [
    Skill(id: 'teaching', name: 'Enseñanza', color: Colors.green),
    Skill(id: 'music', name: 'Música', color: Colors.blue),
    Skill(id: 'technology', name: 'Tecnología', color: Colors.indigo),
    Skill(id: 'languages', name: 'Idiomas', color: Colors.purple),
    Skill(id: 'cooking', name: 'Cocina', color: Colors.orange),
    Skill(id: 'art', name: 'Arte', color: Colors.pink),
  ];

  // Días de la semana
  final List<String> _weekDays = [
    'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
  ];

  // Horarios disponibles
  final List<String> _timeSlots = [
    'Mañanas (9am-12pm)',
    'Tardes (2pm-5pm)',
    'Noches (6pm-9pm)',
    'Fin de semana'
  ];
  
  Set<String> _selectedInterests = {};
  Set<String> _selectedSkills = {};
  Set<String> _selectedDays = {};
  String _selectedTimeSlot = 'Mañanas (9am-12pm)';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppConstants.backgroundColor : AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(), // ← CAMBIO 1
          icon: const Icon(
            Icons.arrow_back,
            color: AppConstants.textColor,
          ),
        ),
        title: const Text(
          'Configura tu perfil',
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Public Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Contenido principal scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Campos básicos
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nombre completo',
                    hintText: 'Tu nombre completo',
                  ),
                  
                  const SizedBox(height: AppConstants.defaultPadding),
                  
                  _buildTextField(
                    controller: _emailController,
                    label: 'Correo electrónico',
                    hintText: 'tucorreo@ejemplo.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  
                  const SizedBox(height: AppConstants.defaultPadding),
                  
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Teléfono',
                    hintText: 'Tu número de teléfono',
                    keyboardType: TextInputType.phone,
                  ),
                  
                  const SizedBox(height: AppConstants.defaultPadding),
                  
                  _buildTextField(
                    controller: _bioController,
                    label: 'Cuéntanos sobre ti',
                    hintText: 'Una breve descripción sobre ti, tus pasiones y lo que te gustaría compartir.',
                    maxLines: 4,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Sección de Intereses
                  _buildSectionTitle('Intereses'),
                  const SizedBox(height: AppConstants.defaultPadding),
                  _buildChipGrid(_interests, _selectedInterests, (id) => _toggleInterest(id)),
                  
                  const SizedBox(height: 32),
                  
                  // Sección de Habilidades
                  _buildSectionTitle('Habilidades'),
                  const SizedBox(height: AppConstants.defaultPadding),
                  _buildSkillChipGrid(_skills, _selectedSkills, (id) => _toggleSkill(id)),
                  
                  const SizedBox(height: 32),
                  
                  // Sección de Disponibilidad
                  _buildSectionTitle('Disponibilidad'),
                  const SizedBox(height: AppConstants.defaultPadding),
                  
                  // Días de la semana
                  Text(
                    'Días de la semana',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppConstants.textColor.withOpacity(0.8),
                      fontFamily: 'Public Sans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDaysSelector(),
                  
                  const SizedBox(height: AppConstants.defaultPadding),
                  
                  // Horarios
                  Text(
                    'Horarios',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppConstants.textColor.withOpacity(0.8),
                      fontFamily: 'Public Sans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTimeSlotDropdown(),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          
          // Botón "Guardar perfil" fijo en la parte inferior
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppConstants.defaultPadding,
              0,
              AppConstants.defaultPadding,
              MediaQuery.of(context).padding.bottom + AppConstants.defaultPadding,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSaveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: AppConstants.primaryColor.withOpacity(0.3),
                ),
                child: const Text(
                  'Guardar perfil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Public Sans',
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
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 16,
            color: AppConstants.textColor,
            fontFamily: 'Public Sans',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppConstants.textColor.withOpacity(0.5),
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppConstants.textColor,
        fontFamily: 'Public Sans',
      ),
    );
  }

  Widget _buildChipGrid(List<Interest> items, Set<String> selectedItems, Function(String) onToggle) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item.id);
        return FilterChip(
          label: Text(
            item.name,
            style: TextStyle(
              color: isSelected ? Colors.white : AppConstants.textColor,
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onToggle(item.id),
          selectedColor: AppConstants.primaryColor,
          backgroundColor: Colors.grey.shade100,
          checkmarkColor: Colors.white,
          side: BorderSide(
            color: isSelected ? AppConstants.primaryColor : Colors.grey.shade300,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillChipGrid(List<Skill> items, Set<String> selectedItems, Function(String) onToggle) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item.id);
        return FilterChip(
          label: Text(
            item.name,
            style: TextStyle(
              color: isSelected ? Colors.white : AppConstants.textColor,
              fontFamily: 'Public Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onToggle(item.id),
          selectedColor: AppConstants.primaryColor,
          backgroundColor: Colors.grey.shade100,
          checkmarkColor: Colors.white,
          side: BorderSide(
            color: isSelected ? AppConstants.primaryColor : Colors.grey.shade300,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDaysSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _weekDays.map((day) {
              final isSelected = _selectedDays.contains(day);
              return FilterChip(
                label: Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppConstants.textColor,
                    fontFamily: 'Public Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                selected: isSelected,
                onSelected: (_) => _toggleDay(day),
                selectedColor: AppConstants.primaryColor,
                backgroundColor: Colors.white,
                checkmarkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                side: BorderSide(
                  color: isSelected ? AppConstants.primaryColor : Colors.grey.shade300,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: _selectedTimeSlot,
        isExpanded: true,
        underline: const SizedBox(),
        style: const TextStyle(
          color: AppConstants.textColor,
          fontSize: 16,
          fontFamily: 'Public Sans',
        ),
        items: _timeSlots.map((timeSlot) {
          return DropdownMenuItem<String>(
            value: timeSlot,
            child: Text(timeSlot),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedTimeSlot = value;
            });
          }
        },
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

  void _toggleSkill(String skillId) {
    setState(() {
      if (_selectedSkills.contains(skillId)) {
        _selectedSkills.remove(skillId);
      } else {
        _selectedSkills.add(skillId);
      }
    });
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _handleSaveProfile() {
    // Validaciones básicas
    if (_nameController.text.trim().isEmpty) {
      _showErrorSnackBar('Por favor ingresa tu nombre');
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _showErrorSnackBar('Por favor ingresa tu correo electrónico');
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      _showErrorSnackBar('Por favor ingresa tu teléfono');
      return;
    }

    if (_selectedDays.isEmpty) {
      _showErrorSnackBar('Por favor selecciona al menos un día de disponibilidad');
      return;
    }

    // Validación adicional de email
    if (!_isValidEmail(_emailController.text.trim())) {
      _showErrorSnackBar('Por favor ingresa un correo electrónico válido');
      return;
    }

    // Simular guardado de datos
    _simulateSaving();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _simulateSaving() {
    // Mostrar loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
              ),
              SizedBox(height: 16),
              Text(
                'Guardando tu perfil...',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Simular tiempo de guardado (2 segundos)
    Future.delayed(const Duration(seconds: 2), () {
      context.pop(); // ← CAMBIO 2 (cerrar loading dialog)
      
      // Navegar a pantalla de éxito
      context.push('/success?userType=volunteer'); // ← CAMBIO 3
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.accentColorLight,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

// Clases auxiliares
class Interest {
  final String id;
  final String name;
  final Color color;

  Interest({
    required this.id,
    required this.name,
    required this.color,
  });
}

class Skill {
  final String id;
  final String name;
  final Color color;

  Skill({
    required this.id,
    required this.name,
    required this.color,
  });
}