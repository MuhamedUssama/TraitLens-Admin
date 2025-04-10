import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/repository/notifications_repository.dart';

import 'notifications_tab_states.dart';

@injectable
class NotificationsTabViewModel extends Cubit<NotificationsTabStates> {
  final NotificationsRepository _notificationsRepository;

  @factoryMethod
  NotificationsTabViewModel(this._notificationsRepository)
    : super(NotificationsTabInitialState()) {
    getAllNotifications();
  }

  Future<void> getAllNotifications() async {
    emit(NotificationsTabLoadingState());
    final result = await _notificationsRepository.getNotifications();
    result.fold(
      (error) => emit(NotificationsTabErrorState(error.toString())),
      (notifications) => emit(NotificationsTabLoadedState(notifications)),
    );
  }

  Future<void> deleteNotification(String notificationId) async {
    emit(NotificationsTabLoadingState());
    final result = await _notificationsRepository.deleteNotification(
      notificationId,
    );
    result.fold(
      (error) => emit(NotificationsTabDeleteErrorState(error.toString())),
      (_) {
        getAllNotifications();
        emit(NotificationsTabDeleteSuccessedState('Notification deleted'));
      },
    );
  }
}
