import 'package:trait_lens_admin/features/tabs/notifications/data/models/notification_model.dart';

abstract class AddNotificationStates {}

class AddNotificationInitialState extends AddNotificationStates {}

class AddNotificationLoadingState extends AddNotificationStates {}

class AddNotificationSuccessState extends AddNotificationStates {
  final NotificationModel notification;
  AddNotificationSuccessState(this.notification);
}

class AddNotificationErrorState extends AddNotificationStates {
  final String? error;
  AddNotificationErrorState(this.error);
}
