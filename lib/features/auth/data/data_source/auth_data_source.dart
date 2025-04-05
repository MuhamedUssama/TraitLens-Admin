import 'package:dartz/dartz.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthDataSource {
  Future<Either<ServerException, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<ServerException, String>> verifyAccount();

  Future<Either<ServerException, String>> forgetPassword({
    required String email,
  });

  Future<void> signOut();
}
