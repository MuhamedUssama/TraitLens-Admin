import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/core/utils/app_dialogs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/add_notification_screen_view_model/add_notification_states.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/add_notification_screen_view_model/add_notifications_view_model.dart';

import 'package:trait_lens_admin/features/tabs/notifications/view/widgets/add_notifications_app_bar_widget.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/widgets/custom_notifications_form.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/widgets/submit_button_widget.dart';

class AddNotificationsScreen extends StatelessWidget {
  static const String routeName = '/add-notifications-screen';
  AddNotificationsScreen({super.key});

  final AddNotificationsViewModel viewModel =
      getIt.get<AddNotificationsViewModel>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AddNotificationsAppBarWidget(),
      body: SingleChildScrollView(
        child: BlocListener<AddNotificationsViewModel, AddNotificationStates>(
          bloc: viewModel,
          listener: (context, state) {
            if (state is AddNotificationSuccessState) {
              AppDialogs.showSuccessDialog(
                context: context,
                message: locale.notificationSentSuccessfully,
                posActionTitle: locale.ok,
              );
            }
            if (state is AddNotificationErrorState) {
              AppDialogs.showFailDialog(
                context: context,
                message: state.error ?? locale.somethingWentWrong,
                posActionTitle: locale.ok,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                SizedBox(height: height * .04),
                FadeInDown(
                  duration: Duration(milliseconds: 600),
                  child: CustomNotificationsForm(viewModel: viewModel),
                ),
                SizedBox(height: height * .3),
                FadeInUp(
                  duration: Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 300),
                  child: SubmitButtonWidget(viewModel: viewModel),
                ),
                SizedBox(height: height * .04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
