
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUserEntity {
  final String name;
  final String email;
  final String profilePhoto;
  final String userID;

  CurrentUserEntity(this.name, this.email, this.profilePhoto, this.userID);

  @override
  int get hashCode =>
    name.hashCode ^ email.hashCode ^ profilePhoto.hashCode ^ userID.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is CurrentUserEntity &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      email == other.email &&
      profilePhoto == other.profilePhoto &&
      userID == other.userID;

  Map<String, Object> toJson() {
    return {
      'name' : name,
      'email' : email,
      'profilePhoto' : profilePhoto,
      'userID' : userID
    };
  }

  @override
  String toString() {
    return 'CurrentUserEntity { name: $name , email: $email , profilePhoto: $profilePhoto , userID: $userID }';
  }

  static CurrentUserEntity fromSnapshot(DocumentSnapshot snap) {
    return CurrentUserEntity(
      snap.data['name'] != null ? snap.data['name'] : null,
      snap.data['email'] != null ? snap.data['email'] : null,
      snap.data['profilePhoto'] != null ? snap.data['profilePhoto'] : null,
      snap.data['userID'] != null ? snap.data['userID'] : null
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name' : name,
      'email' : email,
      'profilePhoto' : profilePhoto,
      'userID' : userID
    };
  }
}