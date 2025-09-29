class UserModel {
  final String id;
  final String email;
  final String password;
  final String name;
  final UserType type;
  final int? age;
  final List<String> interests;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.type,
    this.age,
    this.interests = const [],
  });
}

enum UserType {
  elderly,    
  volunteer,  
}