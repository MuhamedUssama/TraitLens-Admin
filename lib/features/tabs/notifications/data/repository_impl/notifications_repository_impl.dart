import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/core/helpers/connectivity_helper.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/data_source/notifications_remote_data_source.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/models/notification_model.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/repository/notifications_repository.dart';

@Injectable(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource _remoteDataSource;

  @factoryMethod
  NotificationsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ServerException, NotificationModel>> createNotification({
    required NotificationModel notificationModel,
  }) async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _remoteDataSource.createNotification(
        notificationModel: notificationModel,
      );
      return either.fold(
        (error) => left(ServerException(error.toString())),
        (notification) => right(notification),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, String>> deleteAllNotifications() async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _remoteDataSource.deleteAllNotifications();

      return either.fold(
        (error) => left(ServerException(error.toString())),
        (message) => right(message),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, String>> deleteNotification(
    String notificationId,
  ) async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _remoteDataSource.deleteNotification(notificationId);

      return either.fold(
        (error) => left(ServerException(error.toString())),
        (message) => right(message),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<Either<ServerException, List<NotificationModel>>>
  getNotifications() async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _remoteDataSource.getNotifications();

      return either.fold(
        (error) => left(ServerException(error.toString())),
        (notifications) => right(notifications),
      );
    } else {
      return left(const NoInternetConnectionException());
    }
  }

  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      await _remoteDataSource.markNotificationAsRead(notificationId);
    } else {
      throw const NoInternetConnectionException();
    }
  }
}
