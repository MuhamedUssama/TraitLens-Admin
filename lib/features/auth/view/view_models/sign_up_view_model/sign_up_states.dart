import 'package:trait_lens_admin/features/auth/domain/entities/user_entity.dart';

sealed class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  UserEntity? userEntity;
  SignUpSuccessState(this.userEntity);
}

class SignUpErrorState extends SignUpStates {
  String message;
  SignUpErrorState(this.message);
}

class VerifyAccountState extends SignUpStates {
  String message;
  VerifyAccountState(this.message);
}

class NavigateToSignInScreenState extends SignUpStates {}

class NavigateToFillProfileScreenState extends SignUpStates {}
