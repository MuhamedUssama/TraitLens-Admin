import 'package:dartz/dartz.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/features/tabs/users/data/models/detection_result_model.dart';

abstract interface class UsersRepository {
  Future<Either<ServerException, List<UserDetailsModel>>> getUsers();

  Future<Either<ServerException, List<DetectionResultModel>>> getUserResults({
    required String userId,
  });
}
