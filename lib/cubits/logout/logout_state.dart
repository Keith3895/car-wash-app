part of 'logout_cubit.dart';

abstract class LogoutState {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final String message;

  LogoutSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class LogoutFailure extends LogoutState {
  final String message;

  LogoutFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class LogoutError extends LogoutState {
  final String message;

  LogoutError({required this.message});

  @override
  List<Object> get props => [message];
}
