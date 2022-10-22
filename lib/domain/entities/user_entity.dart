import 'package:equatable/equatable.dart';

/// User model
///
class UserEntity extends Equatable {
  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String uid;

  /// The current user's name (display name).
  final String? userName;

  /// full name
  final String? firstName;
  final String? lastName;

  /// The current user's phone number
  final String? phoneNumber;

  /// Url for the current user's photo.
  final String? photo;

  //500*500 version of [photo]
  final String? photoResized;

  /// small version of [photo]
  final String? photoThumbail;

  //devices [code IMEI]
  final List<String> devices;
  final int maxDevices;

  //is the account is activa
  final bool isActive;

  // Empty user which represents an unauthenticated user.
  static const empty = UserEntity(uid: "");

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserEntity.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserEntity.empty;

  const UserEntity({
    this.email,
    required this.uid,
    this.devices = const [],
    this.isActive = false,
    this.maxDevices = 1,
    this.userName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.photo,
    this.photoResized,
    this.photoThumbail,
  });
  @override
  List<Object?> get props => [
        email,
        uid,
        userName,
        phoneNumber,
        photo,
        devices,
        maxDevices,
        isActive,
      ];

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? photo,
    String? phoneNumber,
    bool? isDeveloper,
    bool? isActive,
    List<String>? devices,
    int? maxDevices,
  }) {
    return UserEntity(
      uid: id ?? uid,
      userName: name ?? userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photo: photo ?? this.photo,
      devices: devices ?? this.devices,
      isActive: isActive ?? this.isActive,
      maxDevices: maxDevices ?? this.maxDevices,
    );
  }
}
