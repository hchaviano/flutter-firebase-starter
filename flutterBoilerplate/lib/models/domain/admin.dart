import 'package:flutterBoilerplate/models/domain/user.dart';

class Admin extends User {
  const Admin({
    String id,
    String firstName,
    String lastName,
    String email,
    String avatarAsset,
    bool isAnon,
    int age,
    String phoneNumber,
    String address,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          avatarAsset: avatarAsset,
          isAnon: isAnon,
          age: age,
          address: address,
          phoneNumber: phoneNumber,
        );

  static Admin fromJson(Map<String, dynamic> json) => Admin(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        avatarAsset: json['avatarAsset'],
        isAnon: json['isAnon'],
        age: json['age'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
      );
}
