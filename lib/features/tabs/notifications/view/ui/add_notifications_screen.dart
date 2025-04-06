import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/widgets/custom_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:trait_lens_admin/features/tabs/notifications/view/widgets/add_notifications_app_bar_widget.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/widgets/custom_notifications_form.dart';

class AddNotificationsScreen extends StatelessWidget {
  static const String routeName = '/add-notifications-screen';
  const AddNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AddNotificationsAppBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            Spacer(flex: 1),
            CustomNotificationsForm(),
            Spacer(flex: 8),
            CustomElevatedButton(onPressed: () {}, title: locale.submit),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
