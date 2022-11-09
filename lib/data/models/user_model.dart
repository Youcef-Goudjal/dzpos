import '../../domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    super.email,
    super.devices,
    super.maxDevices,
    super.isActive,
    super.userName,
    super.firstName,
    super.lastName,
    super.phoneNumber,
    super.photo,
    super.photoResized,
    super.photoThumbail,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "devices": devices,
      "maxDevices": maxDevices,
      "photo": photo,
      "isActive": isActive,
      "firstName": firstName,
      "lastName": lastName,
      "photoResized": photoResized,
      "photoThumbail": photoThumbail,
    };
  }

  static const UserModel empty = UserModel(uid: "");

  @override
  bool get isEmpty => this == empty;

  @override
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [
        uid,
        email,
        devices,
        maxDevices,
        isActive,
        userName,
        firstName,
        lastName,
      ];

  static UserModel fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return UserModel.empty;
    } else {
      return UserModel(
        uid: data["uid"],
        userName: data["name"],
        email: data["email"],
        phoneNumber: data["phoneNumber"],
        photo: data["photo"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        photoResized: data["photoResized"],
        photoThumbail: data["photoThumbail"],
        devices: (data["devices"] as List).map((e) => e.toString()).toList(),
        maxDevices: data["maxDevices"],
        isActive: data["isActive"],
      );
    }
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      devices: entity.devices,
      email: entity.email,
      firstName: entity.firstName,
      isActive: entity.isActive,
      lastName: entity.lastName,
      maxDevices: entity.maxDevices,
      phoneNumber: entity.phoneNumber,
      photo: entity.photo,
      photoResized: entity.photoResized,
      photoThumbail: entity.photoThumbail,
      userName: entity.userName,
    );
  }
}

extension UserToModel on User {
  UserModel get toUserModel {
    return UserModel(
      uid: uid,
      email: email,
      userName: displayName,
      phoneNumber: phoneNumber,
      photo: photoURL,
    );
  }
}
