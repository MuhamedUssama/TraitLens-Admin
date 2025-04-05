import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../view_models/sign_in_view_model/sign_in_actions.dart';
import '../view_models/sign_in_view_model/sign_in_states.dart';
import '../view_models/sign_in_view_model/sign_in_view_model.dart';

class SignInForm extends StatelessWidget {
  final SignInViewModel viewModel;

  const SignInForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: viewModel.emailController,
            labelText: AppLocalizations.of(context)!.email,
            hintText: AppLocalizations.of(context)!.enterYourEmail,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator:
                (email) => AppValidator.validateEmailAddress(
                  context: context,
                  email: email,
                ),
          ),
          SizedBox(height: 30.h),
          ValueListenableBuilder(
            valueListenable: viewModel.passwordVisible,
            builder:
                (context, value, child) => CustomTextFormField(
                  controller: viewModel.passwordController,
                  labelText: AppLocalizations.of(context)!.password,
                  hintText: AppLocalizations.of(context)!.enterYourPassword,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: value,
                  suffixIcon: InkWell(
                    onTap: () {
                      viewModel.doIntent(ChangePasswordVisibilityAction());
                    },
                    child: Icon(
                      value ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  validator:
                      (email) => AppValidator.validateFieldIsNotEmpty(
                        value: viewModel.passwordController.text,
                        message: AppLocalizations.of(context)!.emptyPassword,
                      ),
                ),
          ),
          SizedBox(height: 30.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                viewModel.doIntent(NavigateToForgetPasswordScreenAction());
              },
              child: Text(
                AppLocalizations.of(context)!.forgotYourPassword,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed: () {
              viewModel.doIntent(SignInWithEmailAndPasswordAction());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 60.h),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: BlocBuilder<SignInViewModel, SignInStates>(
              bloc: viewModel,
              buildWhen:
                  (previous, current) =>
                      current is SignInLoadingState ||
                      current is SignInErrorState ||
                      current is SignInSuccessState,
              builder: (context, state) {
                return state is SignInLoadingState
                    ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                    : Text(
                      AppLocalizations.of(context)!.signIn,
                      style: Theme.of(context).textTheme.labelLarge,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
