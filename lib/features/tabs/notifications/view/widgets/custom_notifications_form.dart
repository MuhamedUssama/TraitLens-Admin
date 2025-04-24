import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/utils/validation_utils.dart';
import 'package:trait_lens_admin/core/widgets/custom_text_form_field.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/add_notification_screen_view_model/add_notifications_view_model.dart';

class CustomNotificationsForm extends StatelessWidget {
  final AddNotificationsViewModel viewModel;

  const CustomNotificationsForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: Duration(milliseconds: 600),
            child: Text(
              locale.notificationTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 16.h),
          FadeInUp(
            duration: Duration(milliseconds: 600),
            delay: Duration(milliseconds: 200),
            child: CustomTextFormField(
              controller: viewModel.titleController,
              hintText: locale.notificationTitleHint,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator:
                  (value) => AppValidator.validateFieldIsNotEmpty(
                    message: locale.emptyField,
                    value: value,
                  ),
            ),
          ),
          SizedBox(height: 24.h),
          FadeInDown(
            duration: Duration(milliseconds: 600),
            delay: Duration(milliseconds: 400),
            child: Text(
              locale.notifcationDescription,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 16.h),
          FadeInUp(
            duration: Duration(milliseconds: 600),
            delay: Duration(milliseconds: 600),
            child: CustomTextFormField(
              maxLines: 5,
              controller: viewModel.descriptionController,
              hintText: locale.notificationDescriptionHint,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              validator:
                  (value) => AppValidator.validateFieldIsNotEmpty(
                    message: locale.emptyField,
                    value: value,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
