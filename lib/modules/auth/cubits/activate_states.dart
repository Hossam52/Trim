abstract class ActivateStates {}

class InitialActivateState extends ActivateStates {}

class CheckingActivateCodeState extends ActivateStates {}

class ValidActivateCodeStates extends ActivateStates {}

class ErrorActivateStates extends ActivateStates {
  final String error;

  ErrorActivateStates(this.error);
}

class RequestingNewActivatationCodeState extends ActivateStates {}

class SuccessRequestActivationCodeState extends ActivateStates {}

class ErrorRequestActivationCodeState extends ActivateStates {
  final String error;

  ErrorRequestActivationCodeState(this.error);
}
