import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/user_details_app_bar.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/user_information_widget.dart';

class UserDetailsScreen extends StatelessWidget {
  static const String routeName = '/userDetailsScreen';
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDetailsModel user =
        ModalRoute.of(context)!.settings.arguments as UserDetailsModel;
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
        ],
      ),
    );
  }
}
