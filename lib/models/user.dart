import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  // final int age;
  // final String phoneNumber;
  // final String address;

  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    // this.age,
    // this.phoneNumber,
    // this.address,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        imageUrl: json['imageUrl'],
        // age: json['age'],
        // phoneNumber: json['phoneNumber'],
        // address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        // 'age': age,
        // 'address': address,
        // 'phoneNumber': phoneNumber,
      };

  static User fromEntity(UserEntity entity) => User(
        id: entity.id,
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        // age: entity.age,
        // phoneNumber: entity.phoneNumber,
        // address: entity.address,
        imageUrl: entity.imageUrl,
      );

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
        imageUrl,
        // age,
        // phoneNumber,
        // address
      ];

  @override
  bool get stringify => false;
}
