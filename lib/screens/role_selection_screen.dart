import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; 
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/widgets/custom_header.dart';
import 'package:vinculo/widgets/custom_text_field.dart';
import 'package:vinculo/config/providers/auth_provider.dart'; 
import 'package:vinculo/config/providers/interest_provider.dart'; 
import 'package:vinculo/models/user_model.dart'; 
import 'package:vinculo/models/interest_model.dart'; 

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  ConsumerState<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen> {
  UserType? _selectedRole;
  

  DateTime? _selectedDate; 
  String? _selectedGender; 
  String? _selectedPreferredGender; 
  final TextEditingController _bioController = TextEditingController(); 
  final TextEditingController _phoneController = TextEditingController(); 
  final TextEditingController _cityController = TextEditingController(text: 'San Salvador');
  final TextEditingController _countryController = TextEditingController(text: 'El Salvador');
  
  // Voluntario
  bool _hasVolunteerExperience = false; 
  final List<String> _selectedSkills = [];
  final List<String> _selectedDays = [];
  final List<String> _selectedTimeSlots = [];
  
  // Adulto Mayor
  String? _selectedPreference;
  final Map<String, Map<String, dynamic>> _elderlyPreferenceMap = {
    'Bajo-Tech/Baja-Movilidad': {'mobilityLevel': 'low', 'techLevel': 1},
    'Medio-Tech/Movilidad Estándar': {'mobilityLevel': 'medium', 'techLevel': 2},
    'Alta-Tech/Mucha Movilidad': {'mobilityLevel': 'high', 'techLevel': 3}, 
  };

  final List<InterestModel> _selectedInterests = [];
  final List<String> _availableSkills = ['Música', 'Tecnología', 'Arte', 'Cocina', 'Jardinería', 'Lectura'];
  final List<String> _availableDays = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
  final List<String> _availableTimeSlots = ['morning', 'afternoon', 'evening'];

  @override
  void dispose() {
    _bioController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 30), 
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  
  String get _birthDateDisplay {
    if (_selectedDate == null) return 'Selecciona tu Fecha de Nacimiento';
    return DateFormat.yMMMd().format(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    final asyncInterests = ref.watch(interestsProvider);
    final authState = ref.watch(authProvider);
    final isLoading = authState == AuthState.loading;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(showBack: true), 
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        '¿Cómo quieres usar VínculoVital? (Paso 2/2)',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppConstants.textColor, fontFamily: 'Public Sans',),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Selecciona tu rol y completa tu perfil',
                        style: TextStyle(fontSize: 16, color: AppConstants.textColor.withOpacity(0.7), fontFamily: 'Public Sans',),
                      ),
                    const SizedBox(height: 32),

                    // Tarjetas de selección de rol
                    _RoleCard(
                      icon: Icons.elderly,
                      title: 'Adulto Mayor',
                      description: 'Busco compañía y apoyo de voluntarios',
                      isSelected: _selectedRole == UserType.elderly,
                      onTap: () => setState(() => _selectedRole = UserType.elderly),
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      icon: Icons.volunteer_activism,
                      title: 'Voluntario',
                      description: 'Quiero ayudar a adultos mayores',
                      isSelected: _selectedRole == UserType.volunteer,
                      onTap: () => setState(() => _selectedRole = UserType.volunteer),
                    ),

                    if (_selectedRole != null) ...[
                      const SizedBox(height: 32),
                      const Text(
                        'Completa tu perfil',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.textColor,
                          fontFamily: 'Public Sans',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Campos comunes
                      _buildDateSelector(context),
                      const SizedBox(height: 16),
                      CustomTextField(
                          controller: _phoneController,
                          hintText: 'Teléfono (ej. +503xxxxxxx) (Requerido)',
                          keyboardType: TextInputType.phone,
                          prefixIcon: Icons.phone,
                        ),
                      const SizedBox(height: 16),
                      _buildGenderSelector(),
                      const SizedBox(height: 16),
                      _buildPreferredGenderSelector(), 
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _cityController,
                              hintText: 'Ciudad (ej. San Salvador)',
                              prefixIcon: Icons.location_city,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              controller: _countryController,
                              hintText: 'País (ej. El Salvador)',
                              prefixIcon: Icons.public,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _bioController,
                        hintText: 'Cuéntanos un poco sobre ti (Bio)',
                        keyboardType: TextInputType.multiline,
                        prefixIcon: Icons.info_outline,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      
                      // Voluntario
                      if (_selectedRole == UserType.volunteer) ...[
                        _buildSkillsSelector(), 
                        const SizedBox(height: 24),
                        _buildAvailabilitySelector(), 
                        const SizedBox(height: 24),
                        _buildVolunteerExperienceSwitch(), 
                        const SizedBox(height: 24),
                      ],
                      
                      //Adulto Mayor
                      if (_selectedRole == UserType.elderly) ...[
                        _buildElderlyPreferenceSelector(), 
                        const SizedBox(height: 24),
                      ],

                      //intereses
                      const Text(
                        'Intereses',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppConstants.textColor, fontFamily: 'Public Sans',),
                      ),
                      const SizedBox(height: 12),
                      
                      asyncInterests.when(
                        loading: () => const Center(child: CircularProgressIndicator(color: AppConstants.primaryColor)),
                        error: (err, stack) => Text('Error al cargar intereses: ${err.toString().contains('Exception:') ? err.toString().replaceFirst('Exception: ', '') : 'Verifique la conexión.'}'),
                        data: (availableInterests) {
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: availableInterests.map((interest) {
                              final isSelected = _selectedInterests.any((i) => i.id == interest.id);
                              return FilterChip(
                                avatar: Icon(interest.icon, size: 18, color: AppConstants.primaryColor,), 
                                label: Text(interest.name),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedInterests.add(interest);
                                    } else {
                                      _selectedInterests.removeWhere((i) => i.id == interest.id);
                                    }
                                  });
                                },
                                selectedColor: AppConstants.primaryColor.withOpacity(0.3),
                                checkmarkColor: AppConstants.primaryColor,
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
            

            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
              child: _selectedRole != null
                  ? SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator(color: AppConstants.primaryColor))
                          : ElevatedButton(
                              onPressed: _handleRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConstants.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 8,
                              ),
                              child: const Text('Crear cuenta', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Public Sans',),
                              ),
                            ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }


  
  Widget _buildPreferredGenderSelector() {
    return DropdownButtonFormField<String>(
      value: _selectedPreferredGender,
      decoration: InputDecoration(
        labelText: 'Prefiere conectar con',
        hintText: 'ej. male, female, any (Requerido)',
        prefixIcon: const Icon(Icons.people_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: ['male', 'female', 'other', 'any'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value[0].toUpperCase() + value.substring(1)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedPreferredGender = newValue;
        });
      },
    );
  }

  Widget _buildSkillsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilidades (Skills)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppConstants.textColor),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableSkills.map((skill) {
            final isSelected = _selectedSkills.contains(skill);
            return FilterChip(
              label: Text(skill),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedSkills.add(skill);
                  } else {
                    _selectedSkills.remove(skill);
                  }
                });
              },
              selectedColor: AppConstants.secondaryColor.withOpacity(0.3),
              checkmarkColor: AppConstants.secondaryColor,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAvailabilitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Disponibilidad (Días y Horarios)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppConstants.textColor),
        ),
        const SizedBox(height: 12),
        const Text('Días (ej. monday, wednesday):', style: TextStyle(fontWeight: FontWeight.w500)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableDays.map((day) {
            final isSelected = _selectedDays.contains(day);
            return FilterChip(
              label: Text(day.substring(0, 3)),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedDays.add(day);
                  } else {
                    _selectedDays.remove(day);
                  }
                });
              },
              selectedColor: AppConstants.primaryColor.withOpacity(0.3),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        const Text('Horarios (ej. morning, afternoon):', style: TextStyle(fontWeight: FontWeight.w500)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableTimeSlots.map((timeSlot) {
            final isSelected = _selectedTimeSlots.contains(timeSlot);
            return FilterChip(
              label: Text(timeSlot),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTimeSlots.add(timeSlot);
                  } else {
                    _selectedTimeSlots.remove(timeSlot);
                  }
                });
              },
              selectedColor: AppConstants.primaryColor.withOpacity(0.3),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildVolunteerExperienceSwitch() {
    return SwitchListTile(
      title: const Text('Tengo experiencia como voluntario'),
      value: _hasVolunteerExperience,
      onChanged: (bool value) {
        setState(() {
          _hasVolunteerExperience = value;
        });
      },
      secondary: const Icon(Icons.star_border, color: AppConstants.primaryColor),
      activeColor: AppConstants.primaryColor,
    );
  }

  Widget _buildElderlyPreferenceSelector() {
    return DropdownButtonFormField<String>(
      value: _selectedPreference,
      decoration: InputDecoration(
        labelText: 'Nivel de conexión (Requerido)',
        prefixIcon: const Icon(Icons.favorite_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      hint: const Text('Selecciona el perfil de voluntario que buscas'),
      items: _elderlyPreferenceMap.keys.map((String key) {
        return DropdownMenuItem<String>(
          value: key,
          child: Text(key),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedPreference = newValue;
        });
      },
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.cake, color: AppConstants.primaryColor),
            const SizedBox(width: 16),
            Text(
              _birthDateDisplay,
              style: TextStyle(
                fontSize: 16,
                color: _selectedDate == null ? Colors.grey : AppConstants.textColor,
                fontFamily: 'Public Sans',
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGenderSelector() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Género (Requerido)',
        hintText: 'ej. male, female, other',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: ['male', 'female', 'other'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value[0].toUpperCase() + value.substring(1)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
      },
    );
  }


  Future<void> _handleRegister() async {
    // VALIDACIONES
    final phoneText = _phoneController.text.trim();
    if (_selectedDate == null || _selectedGender == null || 
        _bioController.text.trim().isEmpty || _selectedInterests.isEmpty ||
        phoneText.isEmpty || _cityController.text.trim().isEmpty || 
        _countryController.text.trim().isEmpty || _selectedPreferredGender == null) {
      _showError('Por favor completa todos los campos requeridos (Bio, Ciudad, País, Teléfono y Preferencia).');
      return;
    }
    
    if (!phoneText.startsWith('+') || phoneText.length < 10) {
      _showError('El teléfono debe incluir el código de país (ej. +503...).');
      return;
    }
    
    // VALIDACIONES ESPECÍFICAS
    if (_selectedRole == UserType.volunteer && (_selectedDays.isEmpty || _selectedTimeSlots.isEmpty || _selectedSkills.isEmpty)) {
      _showError('Como voluntario, debes seleccionar habilidades, días y horarios de disponibilidad.');
      return;
    }
    if (_selectedRole == UserType.elderly && _selectedPreference == null) {
      _showError('Por favor selecciona tu preferencia de conexión.');
      return;
    }
    
    // PREPARACIÓN DE DATOS
    final registerData = ref.read(registerDataProvider);
    final interestsIDs = _selectedInterests.map((i) => i.id).toList(); 
    final birthDateApi = DateFormat('yyyy-MM-dd').format(_selectedDate!); 

    if (registerData.isEmpty || registerData['name'] == null) {
      _showError('Error: Faltan datos de la pantalla anterior (Nombre, Email, Contraseña).');
      context.goNamed('register');
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);
    LoginResult result;
    
    final commonArgs = {
        'email': registerData['email'] as String,
        'password': registerData['password'] as String,
        'fullName': registerData['name'] as String, 
        'birthDate': birthDateApi,
        'phone': phoneText, 
        'gender': _selectedGender!,
        'bio': _bioController.text.trim(),
        'city': _cityController.text.trim(),
        'country': _countryController.text.trim(),
        'preferredGender': _selectedPreferredGender!,
        'interestIds': interestsIDs,
    };
    
    if (_selectedRole == UserType.elderly) {
        final preferenceValues = _elderlyPreferenceMap[_selectedPreference]!;
        
        result = await authNotifier.registerElderly(
            email: commonArgs['email'] as String,
            password: commonArgs['password'] as String,
            fullName: commonArgs['fullName'] as String,
            birthDate: commonArgs['birthDate'] as String,
            phone: commonArgs['phone'] as String,
            gender: commonArgs['gender'] as String,
            bio: commonArgs['bio'] as String,
            city: commonArgs['city'] as String,
            country: commonArgs['country'] as String,
            preferredGender: commonArgs['preferredGender'] as String,
            interestIds: commonArgs['interestIds'] as List<String>, 
            mobilityLevel: preferenceValues['mobilityLevel'] as String,
            techLevel: preferenceValues['techLevel'] as int, 
        );
    } else {
        final complexAvailability = {
          'days': _selectedDays,
          'timeSlots': _selectedTimeSlots,
        };
        
        result = await authNotifier.registerVolunteer(
            email: commonArgs['email'] as String,
            password: commonArgs['password'] as String,
            fullName: commonArgs['fullName'] as String,
            birthDate: commonArgs['birthDate'] as String,
            phone: commonArgs['phone'] as String,
            gender: commonArgs['gender'] as String,
            bio: commonArgs['bio'] as String,
            city: commonArgs['city'] as String,
            country: commonArgs['country'] as String,
            preferredGender: commonArgs['preferredGender'] as String,
            interestIds: commonArgs['interestIds'] as List<String>, 
            skills: _selectedSkills,
            availability: complexAvailability, 
            hasVolunteerExperience: _hasVolunteerExperience,
        );
    }
    
   
    if (!mounted) return;

    if (result.isSuccess && result.user != null) {
      _showError('¡Bienvenido ${result.user!.fullName}!', isError: false);
      ref.read(registerDataProvider.notifier).state = {};
      

      if (result.user!.type == UserType.elderly) {
        context.goNamed('elderly-home');
      } else {
        context.goNamed('volunteer-home');
      }
    } else {
      _showError(result.errorMessage ?? 'Error desconocido al crear cuenta.');
    }
  }

  void _showError(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppConstants.accentColorLight : AppConstants.primaryColor,
      ),
    );
  }
}


class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppConstants.primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppConstants.primaryColor
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppConstants.primaryColor.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppConstants.primaryColor
                    : AppConstants.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? Colors.white : AppConstants.primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppConstants.primaryColor
                          : AppConstants.textColor,
                      fontFamily: 'Public Sans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppConstants.textColor.withOpacity(0.7),
                      fontFamily: 'Public Sans',
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppConstants.primaryColor,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}