import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trait_lens_admin/features/auth/data/models/user_model.dart';
import 'package:trait_lens_admin/features/fill_profile/data/models/fill_profile_model.dart';

class FireBaseService {
  static CollectionReference<UserModel> getUsersCollection() {
    CollectionReference<UserModel> usersCollection = FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore:
              (documentSnapshot, options) =>
                  UserModel.fromJson(documentSnapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
    return usersCollection;
  }

  static CollectionReference<UserProfileModel> getUserProfileCollection(
    String userId,
  ) {
    CollectionReference<UserProfileModel> userProfileCollection =
        getUsersCollection()
            .doc(userId)
            .collection(UserProfileModel.collectionName)
            .withConverter<UserProfileModel>(
              fromFirestore:
                  (documentSnapshot, options) =>
                      UserProfileModel.fromJson(documentSnapshot.data()!),
              toFirestore: (userProfile, options) => userProfile.toJson(),
            );
    return userProfileCollection;
  }
}
