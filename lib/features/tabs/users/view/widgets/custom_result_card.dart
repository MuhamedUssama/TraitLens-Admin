import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/tabs/users/data/models/detection_result_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/ui/result_details_screen.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/user_details_view_model/user_details_view_model.dart';

class CustomResultCard extends StatelessWidget {
  final UserDetailsViewModel viewModel;
  final DetectionResultModel detectionResult;

  const CustomResultCard({
    super.key,
    required this.viewModel,
    required this.detectionResult,
  });

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
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  height: 150.h,
                  width: 150.w,
                  child: PieChart(
                    PieChartData(
                      sections: viewModel.getPieChartSections(
                        detectionResult.traits!,
                      ),
                      centerSpaceRadius: 55,
                      sectionsSpace: 2,
                      centerSpaceColor: Colors.white,
                      pieTouchData: PieTouchData(enabled: false),
                    ),
                  ),
                ),
                Text(
                  'Total Value',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  detectionResult.dominantTrait ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ResultDetailsScreen.routeName,
                      arguments: detectionResult,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: AppTheme.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Show Details',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
