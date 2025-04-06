import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/widgets/custom_text_form_field.dart';

class CustomNotificationsForm extends StatelessWidget {
  const CustomNotificationsForm({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    return Form(
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale.notificationTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: locale.notificationTitleHint,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 8.h),
          Text(
            locale.notifcationDescription,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          CustomTextFormField(
            maxLines: 5,
            controller: TextEditingController(),
            hintText: locale.notificationDescriptionHint,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
