import 'package:trait_lens_admin/features/auth/domain/entities/user_entity.dart';

sealed class SignInStates {}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInErrorState extends SignInStates {
  final String errorMessage;

  SignInErrorState(this.errorMessage);
}

class SignInSuccessState extends SignInStates {
  final UserEntity userEntity;
  SignInSuccessState(this.userEntity);
}

class NavigateToSignUpScreenState extends SignInStates {}

class NavigateToForgetPasswordScreenState extends SignInStates {}

class NavigateToHomeScreenState extends SignInStates {}
