import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens_admin/features/auth/view/ui/sign_in_screen.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_dialogs.dart';
import '../view_models/forget_password_view_model/forget_password_actions.dart';
import '../view_models/forget_password_view_model/forget_password_states.dart';
import '../view_models/forget_password_view_model/forget_password_view_model.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/forget_password_form.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = '/forget-password-screen';

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ForgetPasswordViewModel viewModel = getIt.get<ForgetPasswordViewModel>();
  String? email;

  @override
  void dispose() {
    viewModel.emailController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String && args.isNotEmpty) {
      email = args;
      viewModel.emailController.text = email!;
    }
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
                    height: 26.h,
                    title: AppLocalizations.of(context)!.forgotPassword,
                    message:
                        AppLocalizations.of(context)!.forgetPasswordMessage,
                    titleTextStyle: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 30.sp),
                    messageTextStyle: Theme.of(context).textTheme.bodySmall!,
                  ),
                  SizedBox(height: 74.h),
                  BlocListener<ForgetPasswordViewModel, ForgetPasswordStates>(
                    bloc: viewModel,
                    listener: (context, state) {
                      if (state is NavigateToLoginScreenState) {
                        Navigator.pushReplacementNamed(
                          context,
                          SignInScreen.routeName,
                        );
                      }
                      if (state is ForgetPasswordSuccessState) {
                        AppDialogs.showSuccessDialog(
                          message:
                              AppLocalizations.of(
                                context,
                              )!.forgetPasswordLinkSentSuccessfully,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                          posAction: () {
                            viewModel.doIntent(NavigateToLoginScreenAction());
                          },
                        );
                      }
                      if (state is ForgetPasswordErrorState) {
                        AppDialogs.showFailDialog(
                          message: state.message,
                          context: context,
                          posActionTitle: AppLocalizations.of(context)!.ok,
                        );
                      }
                    },
                    child: ForgetPasswordForm(viewModel: viewModel),
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
