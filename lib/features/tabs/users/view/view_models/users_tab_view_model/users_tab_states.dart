import 'package:equatable/equatable.dart';
import 'package:trait_lens_admin/core/models/user_details_model.dart';

abstract class UsersTabStates extends Equatable {
  const UsersTabStates();

  @override
  List<Object?> get props => [];
}

class UsersTabInitialState extends UsersTabStates {
  @override
  List<Object?> get props => [];
}

class UsersTabLoadingState extends UsersTabStates {
  @override
  List<Object?> get props => [];
}

class UsersTabLoadedState extends UsersTabStates {
  final List<UserDetailsModel> usersList;

  const UsersTabLoadedState(this.usersList);

  @override
  List<Object?> get props => [usersList];
}

class UsersTabSearchLoadingState extends UsersTabStates {
  @override
  List<Object?> get props => [];
}

class UserTabSearchSuccessState extends UsersTabStates {
  final List<UserDetailsModel> usersList;

  const UserTabSearchSuccessState(this.usersList);

  @override
  List<Object?> get props => [usersList];
}

class UsersTabErrorState extends UsersTabStates {
  final String errorMessage;

  const UsersTabErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
