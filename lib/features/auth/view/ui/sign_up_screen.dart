import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/core/utils/app_assets.dart';
import 'package:trait_lens_admin/features/auth/view/ui/sign_in_screen.dart';
import 'package:trait_lens_admin/features/auth/view/view_models/sign_up_view_model/sign_up_actions.dart';
import 'package:trait_lens_admin/features/fill_profile/view/ui/fill_profile_screen.dart';

import '../../../../core/utils/app_dialogs.dart';
import '../view_models/sign_up_view_model/sign_up_states.dart';
import '../view_models/sign_up_view_model/sign_up_view_model.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/register-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpViewModel viewModel = getIt.get<SignUpViewModel>();

  @override
  void dispose() {
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
    viewModel.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 60.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthHeaderWidget(
                    height: 6.h,
                    title: AppLocalizations.of(context)!.createAccount,
                    message: AppLocalizations.of(context)!.signUpMessage,
                    titleTextStyle: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 30.sp),
                    messageTextStyle: Theme.of(context).textTheme.bodySmall!
                        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 28.h),
                  BlocListener<SignUpViewModel, SignUpStates>(
                    bloc: viewModel,
                    listener: (context, state) {
                      if (state is VerifyAccountState) {
                        AppDialogs.showSuccessDialog(
                          message: state.message,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel.doIntent(
                              NavigateToFillProfileScreenAction(),
                            );
                          },
                        );
                      }
                      if (state is SignUpSuccessState) {
                        AppDialogs.showSuccessDialog(
                          message:
                              AppLocalizations.of(
                                context,
                              )!.accountCreatedSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel.doIntent(VerifyAccountAction());
                          },
                        );
                      }
                      if (state is SignUpErrorState) {
                        AppDialogs.showFailDialog(
                          message: state.message,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                        );
                      }
                      if (state is NavigateToSignInScreenState) {
                        Navigator.pushReplacementNamed(
                          context,
                          SignInScreen.routeName,
                        );
                      }
                      if (state is NavigateToFillProfileScreenState) {
                        Navigator.pushReplacementNamed(
                          context,
                          FillProfileScreen.routeName,
                        );
                      }
                    },
                    child: SignUpForm(viewModel: viewModel),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
