import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/core/utils/firebase_services.dart';
import 'package:trait_lens_admin/features/tabs/profile/domain/entities/fill_profile_entity.dart';

import '../data_source/profile_tab_data_source.dart';

@Injectable(as: ProfileTabDataSource)
class ProfileTabDataSourceImpl implements ProfileTabDataSource {
  @override
  Future<Either<ServerException, UserProfileEntity>> getUserData({
    required String userId,
  }) async {
    try {
      DocumentSnapshot<UserDetailsModel> docSnapshot =
          await FireBaseService.getUserProfileCollection(
            userId,
          ).doc(userId).get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        UserProfileEntity userProfileEntity = docSnapshot.data()!.toEntity();
        return Right(userProfileEntity);
      } else {
        return const Left(ServerException('User profile not found'));
      }
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }

  @override
  Future<Either<ServerException, UserProfileEntity>> updateUserData({
    File? imageFile,
    String? name,
    Timestamp? birthday,
    String? phone,
    String? gender,
  }) async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference<UserDetailsModel> userProfileCollection =
          FireBaseService.getUserProfileCollection(userId);

      DocumentSnapshot<UserDetailsModel> docSnapshot =
          await userProfileCollection.doc(userId).get();

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        return const Left(ServerException('User profile not found'));
      }

      UserDetailsModel currentProfile = docSnapshot.data()!;
      String? profileImageUrl = currentProfile.profileImageUrl;

      if (imageFile != null) {
        final imageUploadResult = await _uploadImageToStorage(
          userId,
          imageFile,
        );

        imageUploadResult.fold(
          (error) => throw error,
          (url) => profileImageUrl = url,
        );
      }

      UserDetailsModel updatedProfile = UserDetailsModel(
        id: userId,
        fullName: name ?? currentProfile.fullName,
        birthDay: birthday ?? currentProfile.birthDay,
        phone: phone ?? currentProfile.phone,
        gender: gender ?? currentProfile.gender,
        profileImageUrl: profileImageUrl,
      );

      await userProfileCollection.doc(userId).set(updatedProfile);

      return Right(updatedProfile.toEntity());
    } on FirebaseException catch (exception) {
      return Left(ServerException(exception.toString()));
    } catch (error) {
      return Left(ServerException(error.toString()));
    }
  }

  Future<void> _deleteOldImages(String userId) async {
    final SupabaseStorageClient storage = Supabase.instance.client.storage;

    final List<FileObject> response = await storage
        .from('profileImages')
        .list(path: 'profile_images/$userId/');

    for (FileObject file in response) {
      await storage.from('profileImages').remove([
        'profile_images/$userId/${file.name}',
      ]);
    }
  }

  Future<File> _compressImage(File imageFile, {int quality = 75}) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception("Failed to decode image");
    }
    Uint8List compressedBytes = Uint8List.fromList(
      img.encodeJpg(image, quality: quality),
    );

    final Directory tempDir = Directory.systemTemp;
    final File compressedFile = File('${tempDir.path}/compressed_image.jpg');
    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }

  Future<Either<ServerException, String>> _uploadImageToStorage(
    String userId,
    File imageFile,
  ) async {
    try {
      await _deleteOldImages(userId);

      File compressedImage = await _compressImage(imageFile, quality: 75);

      final String imagePath =
          'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await Supabase.instance.client.storage
          .from('profileImages')
          .upload(
            imagePath,
            compressedImage,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final String imageUrl = Supabase.instance.client.storage
          .from('profileImages')
          .getPublicUrl(imagePath);

      return Right(imageUrl);
    } on StorageException catch (exception) {
      return Left(ServerException(exception.message));
    } catch (error) {
      return Left(ServerException(error.toString()));
    }
  }

  @override
  Future<Either<ServerException, void>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } on FirebaseException catch (exception) {
      return Left(ServerException(exception.message ?? 'Sign out failed'));
    } catch (error) {
      return Left(ServerException(error.toString()));
    }
  }
}
