import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/models/notification_model.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/repository/notifications_repository.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/add_notification_screen_view_model/add_notification_states.dart';

@injectable
class AddNotificationsViewModel extends Cubit<AddNotificationStates> {
  final NotificationsRepository _notificationsRepository;

  @factoryMethod
  AddNotificationsViewModel(this._notificationsRepository)
    : super(AddNotificationInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> createNotification() async {
    if (formKey.currentState!.validate()) {
      emit(AddNotificationLoadingState());
      NotificationModel notificationModel = NotificationModel(
        title: titleController.text,
        message: descriptionController.text,
        isRead: false,
      );
      final result = await _notificationsRepository.createNotification(
        notificationModel: notificationModel,
      );
      result.fold(
        (error) => emit(AddNotificationErrorState(error.toString())),
        (notification) => emit(AddNotificationSuccessState(notification)),
      );
    }
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
  }

  void disposeControllers() {
    titleController.dispose();
    descriptionController.dispose();
  }
}
