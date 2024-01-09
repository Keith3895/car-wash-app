part of 'onboard_bloc.dart';

abstract class OnboardState {
  const OnboardState();

  @override
  List<Object> get props => [];
}

class OnboardInitial extends OnboardState {}

class OnboardLoading extends OnboardState {}

class OnboadSuccess extends OnboardState {
  const OnboadSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}