import 'package:dartz/dartz.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/models/notification_model.dart';

abstract class NotificationsRepository {
  Future<Either<ServerException, NotificationModel>> createNotification({
    required NotificationModel notificationModel,
  });
  Future<Either<ServerException, List<NotificationModel>>> getNotifications();
  Future<void> markNotificationAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
  Future<void> deleteAllNotifications();
}
