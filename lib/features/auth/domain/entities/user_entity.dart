class UserEntity {
  static const String userCollection = 'users';
  final String id;
  final String email;
  final String role;

  UserEntity({required this.id, required this.email, this.role = 'admin'});
}
