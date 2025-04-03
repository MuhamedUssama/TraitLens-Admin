import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/sign_in_with_email_and_password_usecase.dart';

import 'sign_in_actions.dart';
import 'sign_in_states.dart';

@injectable
class SignInViewModel extends Cubit<SignInStates> {
  final SignInWithEmailAndPasswordUsecase _signInWithEmailAndPasswordUsecase;

  @factoryMethod
  SignInViewModel(this._signInWithEmailAndPasswordUsecase)
    : super(SignInInitialState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> valid = ValueNotifier(false);
  final ValueNotifier<bool> passwordVisible = ValueNotifier(true);

  Future<void> doIntent(SignInActions actions) async {
    switch (actions) {
      case SignInWithEmailAndPasswordAction():
        _signInWithEmailAndPassword();
      case ChangePasswordVisibilityAction():
        _changePasswordVisibility();
      case NavigateToSignUpScreenAction():
        _navigateToSignUpScreen();
      case NavigateToForgetPasswordScreenAction():
        _navigateToForgetPasswordScreen();
      case NavigateToHomeScreenAction():
        _navigateToHomeScreen();
      case FormDataChangedAction():
        _updateValidationState();
    }
  }

  void _updateValidationState() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      valid.value = false;
    } else if (!formKey.currentState!.validate()) {
      valid.value = false;
    } else {
      valid.value = true;
    }
  }

  Future<void> _signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      emit(SignInLoadingState());

      final result = await _signInWithEmailAndPasswordUsecase(
        email: emailController.text,
        password: passwordController.text,
      );

      result.fold(
        (error) => emit(SignInErrorState(error.message.toString())),
        (userEntity) => emit(SignInSuccessState(userEntity)),
      );
    }
  }

  void _changePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void _navigateToForgetPasswordScreen() {
    emit(NavigateToForgetPasswordScreenState());
  }

  void _navigateToHomeScreen() {
    emit(NavigateToHomeScreenState());
  }

  void _navigateToSignUpScreen() {
    emit(NavigateToSignUpScreenState());
  }
}
