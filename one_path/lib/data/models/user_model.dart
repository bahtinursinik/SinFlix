// // models/user_model.dart

// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String photoUrl;

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.photoUrl,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       photoUrl: json['photoUrl'] ?? '',
//     );
//   }
// }
class UserModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? json['_id'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    photoUrl: json['photoUrl'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
  };
}
