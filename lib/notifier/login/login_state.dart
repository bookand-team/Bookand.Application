import 'package:equatable/equatable.dart';

import '../../const/login_result.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final LoginResult loginResult;

  const LoginError(this.loginResult);

  @override
  List<Object> get props => [loginResult];
}
