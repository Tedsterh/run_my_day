
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/entities/current_user_entity/current_user_entity.dart';

@immutable
class CurrentUserModel {
  final String name;
  final String email;
  final String profilePhoto;
  final String userID;

  CurrentUserModel({this.name, this.email, this.profilePhoto, this.userID});

  CurrentUserModel copyWith({String name, String email, String profilePhoto, String userID}) {
    return CurrentUserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      userID: userID ?? this.userID
    );
  }

  @override
  int get hashCode =>
    name.hashCode ^ email.hashCode ^ profilePhoto.hashCode ^ userID.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentUserModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          profilePhoto == other.profilePhoto &&
          userID == other.userID;

  @override
  String toString() {
    return 'CurrentUserModel { name: $name , email: $email , profilePhoto: $profilePhoto , userID: $userID }';
  }

  CurrentUserEntity toEntity() {
    return CurrentUserEntity(name, email, profilePhoto, userID);
  }

  static CurrentUserModel fromEntity(CurrentUserEntity entity) {
    return CurrentUserModel(
      name: entity.name,
      email: entity.email,
      profilePhoto: entity.profilePhoto,
      userID: entity.userID
    );
  }

}