// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String profilePicture;
  final String name;
  final String email;
  final String uid;
  final String password;
  final String coins;
  UserModel({
    required this.profilePicture,
    required this.name,
    required this.email,
    required this.uid,
    required this.password,
    required this.coins,
  });

  UserModel copyWith({
    String? profilePicture,
    String? name,
    String? email,
    String? uid,
    String? password,
    String? coins,
  }) {
    return UserModel(
      profilePicture: profilePicture ?? this.profilePicture,
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      password: password ?? this.password,
      coins: coins ?? this.coins,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profilePicture': profilePicture,
      'name': name,
      'email': email,
      'uid': uid,
      'password': password,
      'coins': coins,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profilePicture: map['profilePicture'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      password: map['password'] as String,
      coins: map['coins'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(profilePicture: $profilePicture, name: $name, email: $email, uid: $uid, password: $password, coins: $coins)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.profilePicture == profilePicture &&
      other.name == name &&
      other.email == email &&
      other.uid == uid &&
      other.password == password &&
      other.coins == coins;
  }

  @override
  int get hashCode {
    return profilePicture.hashCode ^
      name.hashCode ^
      email.hashCode ^
      uid.hashCode ^
      password.hashCode ^
      coins.hashCode;
  }
}
