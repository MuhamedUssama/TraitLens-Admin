import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/tabs/notifications/view/view_models/notifications_tab_view_model/notifications_tab_view_model.dart';

class CustomNotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String notificationId;
  final NotificationsTabViewModel viewModel;

  const CustomNotificationItem({
    super.key,
    required this.title,
    required this.message,
    required this.notificationId,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              viewModel.deleteNotification(notificationId);
            },
            backgroundColor: AppTheme.red,
            foregroundColor: AppTheme.white,
            icon: Icons.delete,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(16.r)),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        child: Row(
          spacing: 12.w,
          children: [
            const Icon(
              Icons.notifications_active_rounded,
              color: AppTheme.black,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppTheme.black),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    message,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: AppTheme.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
