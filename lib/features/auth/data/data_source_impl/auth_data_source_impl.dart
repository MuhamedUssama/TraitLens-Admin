import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';

import 'package:trait_lens_admin/features/auth/data/data_source/auth_data_source.dart';
import 'package:trait_lens_admin/features/auth/data/models/user_model.dart';
import 'package:trait_lens_admin/features/auth/domain/entities/user_entity.dart';

import '../../../../core/utils/firebase_services.dart';

@Singleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<Either<ServerException, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      CollectionReference<UserModel> usersCollection =
          FireBaseService.getUsersCollection();

      QuerySnapshot<UserModel> querySnapshot =
          await usersCollection.where('email', isEqualTo: email).limit(1).get();

      if (querySnapshot.docs.isEmpty) {
        return left(ServerException("User not found in database"));
      }

      UserModel userModel = querySnapshot.docs.first.data();

      if (userModel.role != 'admin') {
        return left(ServerException("Access denied. Only admins can sign in."));
      }

      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        return left(const ServerException("User sign-in failed"));
      }

      if (!credential.user!.emailVerified) {
        await verifyAccount();
        return left(
          ServerException(
            "Please verify your email before signing in. Verification email sent to ${FirebaseAuth.instance.currentUser!.email}",
          ),
        );
      }

      UserEntity userEntity = userModel.toEntity();
      return right(userEntity);
    } on FirebaseAuthException catch (error) {
      return left(ServerException(error.message ?? "Authentication error"));
    }
  }

  @override
  Future<Either<ServerException, String>> verifyAccount() async {
    try {
      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        return right(
          "Verification email sent to ${FirebaseAuth.instance.currentUser!.email}",
        );
      } else {
        return left(const ServerException("Email already verified"));
      }
    } on FirebaseAuthException catch (error) {
      return left(ServerException(error.message));
    }
  }

  @override
  Future<Either<ServerException, String>> forgetPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return right("Password reset email sent to $email");
    } on FirebaseAuthException catch (error) {
      return left(
        ServerException(error.message ?? "Failed to send reset email"),
      );
    }
  }

  @override
  Future<void> signOut() => FirebaseAuth.instance.signOut();
}
