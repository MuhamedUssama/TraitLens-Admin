import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
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
      backgroundColor: AppTheme.white,
      onRefresh: () => viewModel.getAllNotifications(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocConsumer<NotificationsTabViewModel, NotificationsTabStates>(
          bloc: viewModel,
          listenWhen:
              (previous, current) =>
                  current is NotificationsTabDeleteSuccessedState ||
                  current is NotificationsTabDeleteErrorState,
          listener: (context, state) {
            if (state is NotificationsTabDeleteSuccessedState) {
              Fluttertoast.showToast(
                msg: "Notification deleted",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
            if (state is NotificationsTabDeleteErrorState) {
              Fluttertoast.showToast(
                msg: "Something went wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: AppTheme.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
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
                padding: EdgeInsets.symmetric(vertical: 16.h),
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  NotificationModel notification = state.notifications[index];
                  return CustomNotificationItem(
                    viewModel: viewModel,
                    title: notification.title ?? '',
                    message: notification.message ?? '',
                    notificationId: notification.id ?? '',
                  );
                },
              );
            } else {
              return ListView(children: [const SizedBox()]);
            }
          },
        ),
      ),
    );
  }
}
