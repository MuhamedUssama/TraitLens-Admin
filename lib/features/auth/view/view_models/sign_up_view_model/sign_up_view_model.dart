import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/sign_up_with_email_and_password_usecase.dart';
import '../../../domain/use_cases/verify_account_usecase.dart';
import 'sign_up_actions.dart';
import 'sign_up_states.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpStates> {
  final SignUpWithEmailAndPasswordUsecase _signUpWithEmailAndPasswordUsecase;

  final VerifyAccountUsecase _verifyAccountUsecase;

  @factoryMethod
  SignUpViewModel(
    this._signUpWithEmailAndPasswordUsecase,
    this._verifyAccountUsecase,
  ) : super(SignUpInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ValueNotifier<bool> valid = ValueNotifier(false);
  ValueNotifier<bool> passwordVisible = ValueNotifier(true);
  ValueNotifier<bool> passwordConfirmationVisible = ValueNotifier(true);

  Future<void> doIntent(SignUpActions action) async {
    switch (action) {
      case SignUpWithEmailAndPasswordAction():
        _signUpWithEmailAndPassword();
      case NavigateToSignInScreenAction():
        _navigateToLoginScreen();
      case ChangePasswordVisibilityAction():
        _changePasswordVisibility();
      case ChangePasswordConfirmationVisibilityAction():
        _changePasswordConfirmationVisibility();
      case FormDataChangedAction():
        _updateValidationState();
      case VerifyAccountAction():
        _verifyAccount();
      case NavigateToFillProfileScreenAction():
        _navigateToFillProfileScreen();
    }
  }

  void _updateValidationState() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      valid.value = false;
    } else if (!formKey.currentState!.validate()) {
      valid.value = false;
    } else {
      valid.value = true;
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      emit(SignUpLoadingState());

      final result = await _signUpWithEmailAndPasswordUsecase(
        email: emailController.text,
        password: passwordController.text,
      );

      result.fold(
        (error) => emit(SignUpErrorState(error.message.toString())),
        (userEntity) => emit(SignUpSuccessState(userEntity)),
      );
    }
  }

  Future<void> _verifyAccount() async {
    emit(SignUpLoadingState());

    final result = await _verifyAccountUsecase();

    result.fold(
      (error) => emit(SignUpErrorState(error.message.toString())),
      (message) => emit(VerifyAccountState(message)),
    );
  }

  void _changePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void _changePasswordConfirmationVisibility() {
    passwordConfirmationVisible.value = !passwordConfirmationVisible.value;
  }

  void _navigateToLoginScreen() {
    emit(NavigateToSignInScreenState());
  }

  void _navigateToFillProfileScreen() {
    emit(NavigateToFillProfileScreenState());
  }
}
