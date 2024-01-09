part of 'onboard_bloc.dart';

abstract class OnboardEvent {
  const OnboardEvent();
  @override
  List<Object> get props => [];
}

class InitiateOnboard extends OnboardEvent {
  const InitiateOnboard(
      {required this.car_wash_name,
      required this.email,
      required this.phone_number,
      this.GSTN,
      this.PAN,
      required this.registered_company_name,
      required this.bank_account_number,
      this.IFSC,
      this.UPID,
      required this.address});
  final String car_wash_name;
  final String email;
  final String phone_number;
  final String? GSTN;
  final String? PAN;
  final String registered_company_name;
  final String bank_account_number;
  final String? IFSC;
  final String? UPID;
  final String address;

  @override
  List<Object> get props => [
        car_wash_name,
        email,
        phone_number,
        GSTN!,
        PAN!,
        registered_company_name,
        bank_account_number,
        IFSC!,
        UPID!,
        address
      ];
}
