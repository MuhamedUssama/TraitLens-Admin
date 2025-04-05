import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/custom_search_field.dart';
import 'package:trait_lens_admin/features/tabs/users/view/widgets/user_card_widget.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          CustomSearchField(controller: TextEditingController()),
          SizedBox(height: 32.h),
          UserCardWidget(),
        ],
      ),
    );
  }
}
