import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/core/di/di.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/users_tab_view_model/users_tab_states.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/users_tab_view_model/users_tab_view_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/card_loading_widget.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/custom_search_field.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/user_card_widget.dart';

class UsersTab extends StatelessWidget {
  UsersTab({super.key});
  final UsersTabViewModel viewModel = getIt.get<UsersTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          CustomSearchField(
            controller: viewModel.searchController,
            onChanged: (value) => viewModel.searchUsers(value),
          ),
          SizedBox(height: 32.h),
          BlocBuilder<UsersTabViewModel, UsersTabStates>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is UsersTabLoadingState ||
                  state is UsersTabSearchLoadingState) {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder:
                        (context, index) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) => CardLoadingWidget(),
                    itemCount: 8,
                  ),
                );
              }
              if (state is UsersTabErrorState) {
                log(state.errorMessage);
                return Center(child: Text(state.errorMessage));
              }
              if (state is UsersTabLoadedState ||
                  state is UserTabSearchSuccessState) {
                final List<UserDetailsModel> usersList =
                    state is UsersTabLoadedState
                        ? state.usersList
                        : (state as UserTabSearchSuccessState).usersList;

                return Expanded(
                  child: ListView.separated(
                    itemCount: usersList.length,
                    separatorBuilder:
                        (context, index) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      return FadeInLeft(
                        delay: Duration(milliseconds: 100 * index),
                        child: UserCardWidget(
                          user: usersList[index],
                          viewModel: viewModel,
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text('No users found'));
              }
            },
          ),
        ],
      ),
    );
  }
}
