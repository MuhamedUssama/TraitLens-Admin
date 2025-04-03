import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trait_lens_admin/core/utils/validation_utils.dart';
import 'package:trait_lens_admin/core/widgets/custom_text_form_field.dart';

import '../view_models/fill_profile_actions.dart';
import '../view_models/fill_profile_states.dart';
import '../view_models/fill_profile_view_model.dart';
import 'selected_gender_widget.dart';

class FillProfileFormWidget extends StatelessWidget {
  final FillProfileViewModel viewModel;

  const FillProfileFormWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Column(
        children: [
          Form(
            key: viewModel.formKey,
            onChanged: () => viewModel.doIntent(FormDataChangedAction()),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: viewModel.nameController,
                  labelText: locale!.fullName,
                  hintText: locale.fullName,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator:
                      (name) => AppValidator.validateFieldIsNotEmpty(
                        value: name,
                        message: locale.emptyName,
                      ),
                ),
                SizedBox(height: 26.h),
                CustomTextFormField(
                  controller: viewModel.birthdayController,
                  labelText: locale.birthday,
                  hintText: locale.birthday,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  validator:
                      (birthDay) => AppValidator.validateFieldIsNotEmpty(
                        value: birthDay,
                        message: locale.emptyBirthDay,
                      ),
                ),
                SizedBox(height: 26.h),
                CustomTextFormField(
                  controller: viewModel.phoneController,
                  labelText: locale.phoneNumber,
                  hintText: locale.phoneNumber,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  validator:
                      (phone) => AppValidator.validateFieldIsNotEmpty(
                        value: phone,
                        message: locale.emptyPhoneNumber,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: 26.h),
          SelectedGenderWidget(viewModel: viewModel),
          SizedBox(height: 66.h),
          BlocBuilder<FillProfileViewModel, FillProfileStates>(
            bloc: viewModel,
            buildWhen:
                (previous, current) => current is FillProfileLoadingState,
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  viewModel.doIntent(FillProfileDataAction());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 60.h),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child:
                    state is FillProfileLoadingState
                        ? Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                        : Text(
                          locale.submit,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
              );
            },
          ),
        ],
      ),
    );
  }
}
