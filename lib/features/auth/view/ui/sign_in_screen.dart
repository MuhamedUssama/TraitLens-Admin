import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/core/theme/app_theme.dart';
import 'package:trait_lens_admin/features/auth/view/ui/forget_password_screen.dart';
import 'package:trait_lens_admin/features/home/home_screen.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../view_models/sign_in_view_model/sign_in_actions.dart';
import '../view_models/sign_in_view_model/sign_in_states.dart';
import '../view_models/sign_in_view_model/sign_in_view_model.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/login';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInViewModel viewModel = getIt.get<SignInViewModel>();

  @override
  void dispose() {
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
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
                    height: 26.h,
                    title: locale!.loginHere,
                    message: locale.loginMessage,
                    titleTextStyle: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 30.sp),
                    messageTextStyle: Theme.of(context).textTheme.titleLarge!
                        .copyWith(fontSize: 20.sp, color: AppTheme.grey),
                  ),
                  SizedBox(height: 74.h),
                  BlocListener<SignInViewModel, SignInStates>(
                    bloc: viewModel,
                    listener: (context, state) {
                      if (state is SignInErrorState) {
                        AppDialogs.showFailDialog(
                          message: state.errorMessage,
                          context: context,
                          posActionTitle: locale.ok,
                        );
                      }
                      if (state is NavigateToForgetPasswordScreenState) {
                        Navigator.pushNamed(
                          context,
                          ForgetPasswordScreen.routeName,
                          arguments: viewModel.emailController.text,
                        );
                      }
                      if (state is NavigateToHomeScreenState) {
                        Navigator.pushReplacementNamed(
                          context,
                          HomeScreen.routeName,
                        );
                      }
                      if (state is SignInSuccessState) {
                        AppDialogs.showSuccessDialog(
                          message: locale.loggedInSuccessfully,
                          context: context,
                          posActionTitle: locale.ok,
                          posAction: () {
                            viewModel.doIntent(NavigateToHomeScreenAction());
                          },
                        );
                      }
                    },
                    child: SignInForm(viewModel: viewModel),
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
