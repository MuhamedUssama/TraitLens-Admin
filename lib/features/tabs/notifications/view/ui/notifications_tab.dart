import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/features/tabs/notifications/data/models/notification_model.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/notifications_tab_view_model/notifications_tab_states.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/notifications_tab_view_model/notifications_tab_view_model.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/widgets/custom_notification_item.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/widgets/custom_notification_loading_item.dart';

class NotificationsTab extends StatelessWidget {
  NotificationsTab({super.key});

  final NotificationsTabViewModel viewModel =
      getIt.get<NotificationsTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () => viewModel.getAllNotifications(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<NotificationsTabViewModel, NotificationsTabStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is NotificationsTabLoadingState) {
              return ListView.separated(
                itemBuilder:
                    (context, index) => const CustomNotificationLoadingItem(),
                separatorBuilder: (context, index) => Divider(),
                itemCount: 8,
              );
            } else if (state is NotificationsTabErrorState) {
              return Center(child: Text(state.error));
            } else if (state is NotificationsTabLoadedState) {
              return ListView.separated(
                itemCount: state.notifications.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  NotificationModel notification = state.notifications[index];
                  return CustomNotificationItem(
                    title: notification.title ?? '',
                    message: notification.message ?? '',
                  );
                },
              );
            } else {
              return const Center(child: Text('No notifications available'));
            }
          },
        ),
      ),
    );
  }
}
