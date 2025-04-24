import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trait_lens_admin/features/tabs/profile/domain/entities/fill_profile_entity.dart';

class UserDetailsModel {
  static const String collectionName = 'userProfile';

  String? id;
  String? fullName;
  Timestamp? birthDay;
  String? phone;
  String? gender;
  String? profileImageUrl;
  String? email;

  UserDetailsModel({
    this.id,
    this.fullName,
    this.birthDay,
    this.phone,
    this.gender,
    this.profileImageUrl,
    this.email,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      birthDay: json['birthDay'] as Timestamp?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'birthDay': birthDay,
      'phone': phone,
      'gender': gender,
      'profileImageUrl': profileImageUrl,
      'email': email,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      fullName: fullName,
      birthDay: birthDay,
      phone: phone,
      gender: gender,
      profileImageUrl: profileImageUrl,
      email: email,
    );
  }
}
