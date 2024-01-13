part of 'onboard_bloc.dart';

abstract class OnboardEvent {
  const OnboardEvent();
  @override
  List<Object> get props => [];
}

class AddCarWashDetails extends OnboardEvent {
  const AddCarWashDetails({required this.carWashDetails});
  final CarWash carWashDetails;
  @override
  List<Object> get props => [carWashDetails];
}

class getVendorDetails extends OnboardEvent {
  const getVendorDetails();
}
