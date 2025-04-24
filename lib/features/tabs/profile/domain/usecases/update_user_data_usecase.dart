import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/features/tabs/profile/domain/entities/fill_profile_entity.dart';

import '../repository/profile_tab_repository.dart';

@injectable
class UpdateUserDataUsecase {
  final ProfileTabRepository _repository;

  @factoryMethod
  UpdateUserDataUsecase(this._repository);

  Future<Either<ServerException, UserProfileEntity>> call({
    File? imageFile,
    String? name,
    Timestamp? birthday,
    String? phone,
    String? gender,
  }) async {
    return await _repository.updateUserData(
      imageFile: imageFile,
      name: name,
      birthday: birthday,
      phone: phone,
      gender: gender,
    );
  }
}
