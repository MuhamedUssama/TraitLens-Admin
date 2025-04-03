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
  Future<Either<ServerException, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final List<String> methods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        return const Left(
          ServerException(
            "The email address is already in use by another account.",
          ),
        );
      }

      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        return left(const ServerException("User creation failed"));
      }

      UserModel userModel = UserModel(id: credential.user!.uid, email: email);
      CollectionReference<UserModel> usersCollection =
          FireBaseService.getUsersCollection();
      await usersCollection.doc(userModel.id).set(userModel);

      UserEntity userEntity = userModel.toEntity();

      return right(userEntity);
    } on FirebaseAuthException catch (error) {
      return left(ServerException(error.message));
    }
  }

  @override
  Future<Either<ServerException, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        return left(const ServerException("User creation failed"));
      }

      if (!credential.user!.emailVerified) {
        await verifyAccount();
        return left(
          ServerException(
            "Please verify your email before signing in, Verification email sent to ${FirebaseAuth.instance.currentUser!.email}",
          ),
        );
      }

      CollectionReference<UserModel> usersCollection =
          FireBaseService.getUsersCollection();

      DocumentSnapshot<UserModel> documentSnapShot =
          await usersCollection.doc(credential.user!.uid).get();

      UserModel userModel = documentSnapShot.data()!;
      UserEntity userEntity = userModel.toEntity();

      return right(userEntity);
    } on FirebaseAuthException catch (error) {
      return left(ServerException(error.message));
    }
  }

  @override
  Future<void> signOut() => FirebaseAuth.instance.signOut();

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
}
