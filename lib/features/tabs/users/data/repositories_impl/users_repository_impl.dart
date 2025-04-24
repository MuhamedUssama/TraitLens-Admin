import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/core/helpers/connectivity_helper.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/features/tabs/users/data/data_sources/users_remote_data_source.dart';
import 'package:trait_lens_admin/features/tabs/users/data/models/detection_result_model.dart';
import 'package:trait_lens_admin/features/tabs/users/data/repositories/users_repository.dart';

@Injectable(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource _usersRemoteDataSource;

  @factoryMethod
  UsersRepositoryImpl(this._usersRemoteDataSource);

  @override
  Future<Either<ServerException, List<UserDetailsModel>>> getUsers() async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      return await _usersRemoteDataSource.getAllUserProfilesForAllUsers();
    } else {
      return Left(NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, List<DetectionResultModel>>>
  getUserResults() async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      return _usersRemoteDataSource.getUserResults();
    } else {
      return Left(NoInternetConnectionException());
    }
  }
}
