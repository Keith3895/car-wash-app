import 'package:car_wash/models/car_wash.dart';
import 'package:car_wash/repos/vendorRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final VendorRepo vendorRepo;
  OnboardBloc({required this.vendorRepo}) : super(OnboardInitial()) {
    on<AddCarWashDetails>((event, emit) async => addCarWash(emit, event: event));
  }

  addCarWash(Emitter<OnboardState> emit, {AddCarWashDetails? event}) async {
    // emit OnboardLoading();
    try {
      final response = await vendorRepo.addCarWashDetails(carWashDetails: event!.carWashDetails);
      if (response == true) {
        emit(OnboadSuccess(message: response.message));
      } else {
        emit(OnboardError(message: response));
      }
    } catch (e) {
      emit(OnboardError(message: e.toString()));
    }
  }
}
