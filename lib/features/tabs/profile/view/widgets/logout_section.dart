import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/core/utils/app_dialogs.dart';
import 'package:trait_lens_admin/features/auth/view/ui/sign_in_screen.dart';

import '../view_model/profile_tab/profile_tab_actions.dart';
import '../view_model/profile_tab/profile_tab_states.dart';
import '../view_model/profile_tab/profile_tab_view_model.dart';

class LogoutSection extends StatelessWidget {
  final ProfileTabViewModel viewModel;

  const LogoutSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);

    return BlocListener<ProfileTabViewModel, ProfileTabStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          AppDialogs.showSuccessDialog(
            message: locale.logoutSuccess,
            context: context,
            posActionTitle: locale.ok,
            posAction: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          );
        }
      },
      child: InkWell(
        onTap: () {
          viewModel.doIntent(LogOutAction());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.logout, color: AppTheme.black, size: 16),
                  SizedBox(width: 4.w),
                  Text(
                    locale!.logout,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
              const Icon(Icons.logout, color: AppTheme.primary, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
