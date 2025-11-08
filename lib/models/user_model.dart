import 'package:vinculo/models/interest_model.dart'; 

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final UserType type;
  final String? preferredGender;
  final String? bio;
  final String? birthDate; 
  final List<InterestModel> interests; 

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.type,
    this.preferredGender,
    this.bio,
    this.birthDate,
    this.interests = const [], 
  });


  static UserType _parseUserType(String type) {
    final userTypeString = type.toLowerCase();
    
    if (userTypeString == 'elder' || userTypeString == 'elderly') {
      return UserType.elderly;
    }
    if (userTypeString == 'young' || userTypeString == 'volunteer') {
      return UserType.volunteer;
    }
    return UserType.elderly; 
  }
  

  factory UserModel.fromJson(Map<String, dynamic> json) {
    
    //parsear lista de intereses (si existe)
    final interestsList = json['interests'] as List<dynamic>?;
    final parsedInterests = interestsList != null
        ? interestsList.map((i) => InterestModel.fromJson(i as Map<String, dynamic>)).toList()
        : <InterestModel>[]; // vacía si 'interests' es nulo

    return UserModel(
      id: json['id'].toString(),
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      type: _parseUserType(json['userType'] as String), 
      preferredGender: json['preferredGender'] as String?,
      bio: json['bio'] as String?,
      birthDate: json['birthDate'] as String?, 
      interests: parsedInterests, 
    );
  }
}

enum UserType {
  elderly,    
  volunteer,  
}