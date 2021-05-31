abstract class AuthStates {}

class IntialAuthLoginState extends AuthStates {}

class IntialAuthRegisterState extends AuthStates {}

class ErrorAuthState extends AuthStates {
  final String errorMessage;

  ErrorAuthState(this.errorMessage);
}

class LoadingAuthState extends AuthStates {}

class LoadedAuthState extends AuthStates {}

class LoadingUserDetailState extends AuthStates {}

class LoadedUserDetailState extends AuthStates {}

class ErrorUserDetailState extends AuthStates {
  final String errorMessage;

  ErrorUserDetailState(this.errorMessage);
}

class InvalidFieldState extends AuthStates {
  final String errorMessage;

  InvalidFieldState(this.errorMessage);
}

class LoadingRegisterState extends AuthStates {}

class LoadedRegisterState extends AuthStates {}

class ErrorRegisterState extends AuthStates {
  final String errorMessage;

  ErrorRegisterState(this.errorMessage);
}

class ChangingPasswordState extends AuthStates {}

class SuccessChangedPasswordState extends AuthStates {}

class ErrorChangingPasswordState extends AuthStates {
  final String error;

  ErrorChangingPasswordState(this.error);
}

class NotActivatedAccountState extends AuthStates {}

class ChangeGenderState extends AuthStates {}

class UpdatingUserInformationState extends AuthStates {}

class SuccessUpdatingUserInformationState extends AuthStates {}

class NoUpdatingUserInformationState extends AuthStates {}

class ErrorUpdatingUserInformationState extends AuthStates {
  final String error;

  ErrorUpdatingUserInformationState(this.error);
}

class LoadingLogoutState extends AuthStates {}

class LoadedLogoutState extends AuthStates {}

class ErrorLogoutState extends AuthStates {
  final String error;

  ErrorLogoutState(this.error);
}
