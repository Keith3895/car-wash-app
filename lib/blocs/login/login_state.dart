part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class EmailLoginLoading extends LoginState {
  const EmailLoginLoading();
}

class GoogleLoginLoading extends LoginState {
  const GoogleLoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class LoginError extends LoginState {
  const LoginError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
