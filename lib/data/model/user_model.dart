class UserModel {
  final String name;
  final String email;
  final String profile;
  UserModel({required this.name, required this.email, required this.profile});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profile: json['profile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'profile': profile};
  }

  UserModel copyWith({String? name, String? email, String? profile}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profile: profile ?? this.profile,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, profile: $profile)';
  }
}
