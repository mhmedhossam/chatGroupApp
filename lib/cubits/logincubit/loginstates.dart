class LoginStates {}

class Initialstate extends LoginStates {}

class LoginSucceeded extends LoginStates {
  final String name;
  LoginSucceeded({required this.name});
}

class Loginloading extends LoginStates {}

class LoginFailure extends LoginStates {
  final String? errorMessage;
  LoginFailure({this.errorMessage});
}
