import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';

class AddNotificationsAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AddNotificationsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppTheme.black),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        onPressed: () => Navigator.of(context).pop(),
      ),
      leadingWidth: 32.w,
      title: const Text('Notifications'),
      titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        color: AppTheme.black,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
