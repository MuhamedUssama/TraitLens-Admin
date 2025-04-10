import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/add_notification_screen_view_model/add_notification_states.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/add_notification_screen_view_model/add_notifications_view_model.dart';

class SubmitButtonWidget extends StatelessWidget {
  final AddNotificationsViewModel viewModel;

  const SubmitButtonWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return ElevatedButton(
      onPressed: () => viewModel.createNotification(),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60.h),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: BlocBuilder<AddNotificationsViewModel, AddNotificationStates>(
        bloc: viewModel,
        builder: (context, state) {
          return state is AddNotificationLoadingState
              ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 40,
                ),
              )
              : Text(
                locale.submit,
                style: Theme.of(context).textTheme.labelLarge,
              );
        },
      ),
    );
  }
}
