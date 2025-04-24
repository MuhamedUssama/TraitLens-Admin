import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';

import '../repository/profile_tab_repository.dart';

@injectable
class SignOutUsecase {
  final ProfileTabRepository _repository;

  @factoryMethod
  SignOutUsecase(this._repository);

  Future<Either<ServerException, void>> call() async {
    return await _repository.signOut();
  }
}
