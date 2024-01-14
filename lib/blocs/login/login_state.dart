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

class NoUserType extends LoginState {
  const NoUserType({required this.message});
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

class AddUserTypeLoading extends LoginState {
  const AddUserTypeLoading();
}

class AddUserTypeSuccess extends LoginState {
  const AddUserTypeSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class AddUserTypeError extends LoginState {
  const AddUserTypeError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
