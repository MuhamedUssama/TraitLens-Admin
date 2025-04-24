import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/features/tabs/profile/domain/entities/fill_profile_entity.dart';

import '../repository/profile_tab_repository.dart';

@injectable
class GetUserDataUsecase {
  ProfileTabRepository repository;

  @factoryMethod
  GetUserDataUsecase(this.repository);

  Future<Either<ServerException, UserProfileEntity>> call({
    required String userId,
  }) async {
    return repository.getUserData(userId: userId);
  }
}
