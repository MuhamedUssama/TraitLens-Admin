import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/tabs/users/data/models/detection_result_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/user_details_view_model/user_details_view_model.dart';

class CustomResultCard extends StatelessWidget {
  final UserDetailsViewModel viewModel;
  final DetectionResultModel detectionResul;

  const CustomResultCard({
    super.key,
    required this.viewModel,
    required this.detectionResul,
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
                        detectionResul.traits!,
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
                  detectionResul.dominantTrait ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
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
