import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';

class CustomResultCardLoading extends StatelessWidget {
  const CustomResultCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppTheme.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: AppTheme.primary),
      ),
      child: Container(
        height: 200.h,
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 150.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(height: 20.h, width: 80.w, color: Colors.grey[300]),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 20.h,
                    width: 100.w,
                    color: Colors.grey[300],
                  ),
                  Container(
                    height: 40.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
