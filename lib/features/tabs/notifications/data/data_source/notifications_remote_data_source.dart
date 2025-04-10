import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/core/constants/app_constants.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/core/helpers/firebase_auth_helper.dart';
import 'package:trait_lens_admin/core/utils/firebase_services.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/models/notification_model.dart';

@lazySingleton
class NotificationsRemoteDataSource {
  Future<Either<ServerException, NotificationModel>> createNotification({
    required NotificationModel notificationModel,
  }) async {
    try {
      final String? accessToken = await FirebaseAuthHelper.getAccessToken();
      if (accessToken == null) {
        return Left(ServerException('Failed to get access token'));
      }

      final Uri url = Uri.parse(AppConstants.firebaseEndPoint);

      final docRef = FireBaseService.getNotificationsCollection().doc();

      NotificationModel updatedNotification = notificationModel.copyWith(
        id: docRef.id,
      );

      final Map<String, Map<String, dynamic>> body = {
        "message": {
          "topic": AppConstants.generalTopicName,
          "notification": {
            "title": updatedNotification.title,
            "body": updatedNotification.message,
          },
          "data": {
            "id": updatedNotification.id,
            "isRead": updatedNotification.isRead.toString(),
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
          },
        },
      };

      final http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        await docRef.set(updatedNotification);
        return Right(updatedNotification);
      } else {
        log('❌ FCM Error: ${response.body}');
        return Left(ServerException('Failed to send notification'));
      }
    } catch (e) {
      log('❌ Exception: $e');
      return Left(ServerException(e.toString()));
    }
  }

  Future<Either<ServerException, List<NotificationModel>>>
  getNotifications() async {
    try {
      final QuerySnapshot<NotificationModel> snapshot =
          await FireBaseService.getNotificationsCollection()
              .orderBy('id', descending: true)
              .get();

      List<NotificationModel> notifications =
          snapshot.docs.map((doc) => doc.data()).toList();

      return Right(notifications);
    } catch (e) {
      log('❌ Get Notifications Error: $e');
      return Left(ServerException('Failed to fetch notifications'));
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      final QuerySnapshot<NotificationModel> querySnapshot =
          await FireBaseService.getNotificationsCollection()
              .where('id', isEqualTo: notificationId)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentReference<NotificationModel> docRef =
            querySnapshot.docs.first.reference;

        await docRef.update({'isRead': true});
      }
    } catch (e) {
      log('❌ Mark as Read Error: $e');
    }
  }

  Future<Either<ServerException, String>> deleteNotification(
    String notificationId,
  ) async {
    try {
      final QuerySnapshot<NotificationModel> querySnapshot =
          await FireBaseService.getNotificationsCollection()
              .where('id', isEqualTo: notificationId)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        return Right(notificationId);
      } else {
        return Left(ServerException('Notification not found'));
      }
    } catch (e) {
      log('❌ Delete Notification Error: $e');
      return Left(ServerException('Failed to delete notification'));
    }
  }

  Future<Either<ServerException, String>> deleteAllNotifications() async {
    try {
      final QuerySnapshot<NotificationModel> snapshot =
          await FireBaseService.getNotificationsCollection().get();

      for (QueryDocumentSnapshot<NotificationModel> doc in snapshot.docs) {
        await doc.reference.delete();
      }

      return Right('All notifications deleted');
    } catch (e) {
      log('❌ Delete All Notifications Error: $e');
      return Left(ServerException('Failed to delete all notifications'));
    }
  }
}
