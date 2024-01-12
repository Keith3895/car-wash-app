part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class InitiateEmailSignIn extends LoginEvent {
  const InitiateEmailSignIn({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class InitiateGoogleSignIn extends LoginEvent {}

class AddUserType extends LoginEvent {
  const AddUserType({required this.userType});
  final int userType;

  @override
  List<Object> get props => [userType];
}
