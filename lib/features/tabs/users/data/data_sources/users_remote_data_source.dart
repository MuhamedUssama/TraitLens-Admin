import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/core/utils/firebase_services.dart';
import 'package:trait_lens_admin/features/auth/data/models/user_model.dart';

@lazySingleton
class UsersRemoteDataSource {
  Future<Either<ServerException, List<UserDetailsModel>>>
  getAllUserProfilesForAllUsers() async {
    List<UserDetailsModel> allProfiles = [];

    try {
      final QuerySnapshot<UserModel> usersSnapshot =
          await FireBaseService.getUsersCollection()
              .where('role', isEqualTo: 'user')
              .get();

      for (QueryDocumentSnapshot<UserModel> userDoc in usersSnapshot.docs) {
        final String userId = userDoc.id;

        DocumentSnapshot<UserDetailsModel> userProfileSnapshot =
            await FireBaseService.getUserProfileCollection(
              userId,
            ).doc(userId).get();

        if (userProfileSnapshot.exists) {
          UserDetailsModel? profile = userProfileSnapshot.data();
          if (profile != null) {
            allProfiles.add(profile);
          }
        }
      }

      return Right(allProfiles);
    } catch (exception) {
      return Left(ServerException(exception.toString()));
    }
  }
}
