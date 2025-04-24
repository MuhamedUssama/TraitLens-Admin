import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/tabs/users/data/models/detection_result_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/user_details_view_model/user_details_view_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/detection_app_bar.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/status_section.dart';

class ResultDetailsScreen extends StatelessWidget {
  static const String routeName = '/resultDetailsScreen';
  const ResultDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    final DetectionResultModel detectionResult =
        ModalRoute.of(context)!.settings.arguments as DetectionResultModel;

    final UserDetailsViewModel viewModel = getIt.get<UserDetailsViewModel>();

    return Scaffold(
      appBar: DetectionAppBar(title: locale!.results),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 45.w),
        child: Column(
          children: [
            const Spacer(flex: 1),
            FadeInDown(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SizedBox(
                    height: 250.h,
                    child: PieChart(
                      PieChartData(
                        sections: viewModel.getPieChartSections(
                          detectionResult.traits!,
                          radius: 50,
                          titleColor: AppTheme.black,
                        ),
                        centerSpaceRadius: 70,
                        sectionsSpace: 2,
                        centerSpaceColor: Colors.white,
                        pieTouchData: PieTouchData(enabled: false),
                      ),
                    ),
                  ),
                  Text(
                    detectionResult.dominantTrait ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80.h),
            StatusSection(traits: detectionResult.traits),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
