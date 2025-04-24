import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/shared/language_view_model/language_view_model.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';

class LanguageSectionWidget extends StatelessWidget {
  const LanguageSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    LanguageViewModel languageViewModel = context.read<LanguageViewModel>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.translate, color: AppTheme.black),
              SizedBox(width: 4.w),
              Text(
                locale!.language,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              String newLanguage = locale.localeName == 'en' ? 'ar' : 'en';
              languageViewModel.changeLanguage(newLanguage);
            },
            child: Text(
              locale.languageKeyword,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
