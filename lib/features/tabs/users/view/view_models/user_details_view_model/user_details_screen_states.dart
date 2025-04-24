import 'package:trait_lens_admin/features/tabs/users/data/models/detection_result_model.dart';

sealed class UserDetailsScreenStates {}

class UserDetailsScreenInitialState extends UserDetailsScreenStates {}

class UserDetailsScreenLoadingState extends UserDetailsScreenStates {}

class UserDetailsScreenErrorState extends UserDetailsScreenStates {
  final String errorMessage;

  UserDetailsScreenErrorState(this.errorMessage);
}

class UserDetailsScreenEmptyState extends UserDetailsScreenStates {}

class UserDetailsScreenLoadedState extends UserDetailsScreenStates {
  final List<DetectionResultModel> userDetailsModel;

  UserDetailsScreenLoadedState(this.userDetailsModel);
}
