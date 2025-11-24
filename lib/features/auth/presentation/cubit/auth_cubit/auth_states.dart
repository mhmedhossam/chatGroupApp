class AuthStates {}

class InitialState extends AuthStates {}

class AuthSucceededState extends AuthStates {
  final String? name;
  AuthSucceededState({this.name});
}

class AuthLoadingState extends AuthStates {}

class AuthFailureState extends AuthStates {
  final String? errorMessage;
  AuthFailureState({this.errorMessage});
}
