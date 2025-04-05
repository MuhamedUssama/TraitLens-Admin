import 'package:flutter/material.dart';
import 'package:trait_lens_admin/core/constants/app_constants.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';
import 'package:trait_lens_admin/features/tabs/users/view/view_models/users_tab_view_model/users_tab_view_model.dart';

class UserCardWidget extends StatelessWidget {
  final UserDetailsModel user;
  final UsersTabViewModel viewModel;

  const UserCardWidget({
    super.key,
    required this.user,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            user.profileImageUrl ?? AppConstants.noFoundImage,
          ),
        ),
        title: Text(user.fullName ?? 'Unknown'),
        subtitle: Text('${viewModel.calculateAge(user.birthDay)} years old'),
        trailing: FilledButton(
          onPressed: () {},
          child: Text(
            'more details',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
