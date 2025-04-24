import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:trait_lens_admin/core/di/di.dart';

import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/core/utils/animation_assets.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/user_details_view_model/user_details_screen_states.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/user_details_view_model/user_details_view_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/cusom_result_card_loading_widget.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/custom_result_card.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/user_details_app_bar.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/user_information_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  static const String routeName = '/userDetailsScreen';

  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final UserDetailsViewModel viewModel = getIt.get<UserDetailsViewModel>();
  late final UserDetailsModel user;
  bool _isUserInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_isUserInitialized) {
      user = ModalRoute.of(context)!.settings.arguments as UserDetailsModel;
      if (user.id != null) {
        viewModel.getUserDetectionResults(userId: user.id!);
      }
      _isUserInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          UserDetailsAppBar(imageUrl: user.profileImageUrl),
          SliverToBoxAdapter(child: SizedBox(height: 18.h)),
          UserInformationWidget(user: user),
          SliverToBoxAdapter(child: SizedBox(height: 18.h)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'History',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          BlocBuilder<UserDetailsViewModel, UserDetailsScreenStates>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is UserDetailsScreenLoadingState) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  sliver: SliverList.separated(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const CustomResultCardLoading();
                    },
                    separatorBuilder:
                        (context, index) => SizedBox(height: 16.h),
                  ),
                );
              }
              if (state is UserDetailsScreenErrorState) {
                return SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(AnimationsAssets.errorAnimation),
                      Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed:
                            () => viewModel.getUserDetectionResults(
                              userId: user.id!,
                            ),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              if (state is UserDetailsScreenLoadedState) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 16.h,
                  ),
                  sliver: SliverList.separated(
                    itemCount: state.userDetailsModel.length,
                    itemBuilder: (context, index) {
                      return FadeInLeft(
                        delay: Duration(milliseconds: 100 * index),
                        child: CustomResultCard(
                          viewModel: viewModel,
                          detectionResult: state.userDetailsModel[index],
                        ),
                      );
                    },
                    separatorBuilder:
                        (context, index) => SizedBox(height: 16.h),
                  ),
                );
              }
              if (state is UserDetailsScreenEmptyState) {
                return SliverToBoxAdapter(
                  child: LottieBuilder.asset(AnimationsAssets.emptyList),
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
