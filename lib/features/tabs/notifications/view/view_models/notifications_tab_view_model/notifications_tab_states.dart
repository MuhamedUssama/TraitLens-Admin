import 'package:trait_lens_admin/features/tabs/notifications/data/models/notification_model.dart';

abstract class NotificationsTabStates {}

class NotificationsTabInitialState extends NotificationsTabStates {}

class NotificationsTabLoadingState extends NotificationsTabStates {}

class NotificationsTabLoadedState extends NotificationsTabStates {
  final List<NotificationModel> notifications;

  NotificationsTabLoadedState(this.notifications);
}

class NotificationsTabErrorState extends NotificationsTabStates {
  final String error;

  NotificationsTabErrorState(this.error);
}

class NotificationsTabDeleteSuccessedState extends NotificationsTabStates {
  final String notificationId;

  NotificationsTabDeleteSuccessedState(this.notificationId);
}

class NotificationsTabDeleteErrorState extends NotificationsTabStates {
  final String error;

  NotificationsTabDeleteErrorState(this.error);
}
