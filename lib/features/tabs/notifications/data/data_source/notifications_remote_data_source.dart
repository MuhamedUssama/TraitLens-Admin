import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:trait_lens_admin/core/constants/app_constants.dart';
import 'package:trait_lens_admin/core/errors/exceptions.dart';
import 'package:trait_lens_admin/core/helpers/firebase_auth_helper.dart';
import 'package:trait_lens_admin/core/utils/firebase_services.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/models/notification_model.dart';

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

      final Map<String, Map<String, dynamic>> body = {
        "message": {
          "topic": AppConstants.generalTopicName,
          "notification": {
            "title": notificationModel.title,
            "body": notificationModel.message,
          },
          "data": {
            "id": notificationModel.id ?? '',
            "isRead": notificationModel.isRead.toString(),
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
        await FireBaseService.getNotificationsCollection().add(
          notificationModel,
        );

        return Right(notificationModel);
      } else {
        log('❌ FCM Error: ${response.body}');
        return Left(ServerException('Failed to send notification'));
      }
    } catch (e) {
      log('❌ Exception: $e');
      return Left(ServerException(e.toString()));
    }
  }
}
