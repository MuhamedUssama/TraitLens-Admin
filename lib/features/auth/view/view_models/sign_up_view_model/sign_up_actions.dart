sealed class SignUpActions {}

class SignUpWithEmailAndPasswordAction extends SignUpActions {}

class NavigateToSignInScreenAction extends SignUpActions {}

class NavigateToFillProfileScreenAction extends SignUpActions {}

class ChangePasswordVisibilityAction extends SignUpActions {}

class ChangePasswordConfirmationVisibilityAction extends SignUpActions {}

class FormDataChangedAction extends SignUpActions {}

class VerifyAccountAction extends SignUpActions {}
