class UserDetailsModel {
  static const String collectionName = 'userProfile';

  String? id;
  String? fullName;
  String? birthDay;
  String? phone;
  String? gender;
  String? profileImageUrl;

  UserDetailsModel({
    this.id,
    this.fullName,
    this.birthDay,
    this.phone,
    this.gender,
    this.profileImageUrl,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      birthDay: json['birthDay'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
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
    };
  }
}
