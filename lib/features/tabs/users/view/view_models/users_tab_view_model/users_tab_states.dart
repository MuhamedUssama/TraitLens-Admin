import 'package:trait_lens_admin/core/models/user_details_model.dart';

abstract class UsersTabStates {}

class UsersTabInitialState extends UsersTabStates {}

class UsersTabLoadingState extends UsersTabStates {}

class UsersTabLoadedState extends UsersTabStates {
  final List<UserDetailsModel> usersList;
  UsersTabLoadedState(this.usersList);
}

class UsersTabSearchLoadingState extends UsersTabStates {}

class UserTabSearchSuccessState extends UsersTabStates {
  final List<UserDetailsModel> usersList;
  UserTabSearchSuccessState(this.usersList);
}

class UsersTabErrorState extends UsersTabStates {
  final String errorMessage;
  UsersTabErrorState(this.errorMessage);
}
