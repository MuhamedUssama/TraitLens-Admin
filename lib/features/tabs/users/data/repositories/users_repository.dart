import 'package:dartz/dartz.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';

abstract interface class UsersRepository {
  Future<Either<ServerException, List<UserDetailsModel>>> getUsers();
}
