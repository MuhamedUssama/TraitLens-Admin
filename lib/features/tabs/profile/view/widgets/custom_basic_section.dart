import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';

class CustomBasicSection extends StatelessWidget {
  final String title;

  const CustomBasicSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontSize: 14.sp),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppTheme.grey, size: 18),
          ],
        ),
      ),
    );
  }
}
