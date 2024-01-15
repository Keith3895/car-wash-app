
import 'package:car_wash/models/car_wash.dart';
import 'package:car_wash/repos/vendorRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final VendorRepo vendorRepo;
  OnboardBloc({required this.vendorRepo}) : super(OnboardInitial()) {
    on<AddCarWashDetails>((event, emit) async => addCarWash(emit, event: event));
    on<getVendorDetails>((event, emit) async => emit(const NoVendorDetails()));
  }

  addCarWash(Emitter<OnboardState> emit, {AddCarWashDetails? event}) async {
    // emit OnboardLoading();

    CarWash carWash = event!.carWashDetails;
    carWash = await _ImageResolver(carWash, emit);
    try {
      final response = await vendorRepo.addCarWashDetails(carWashDetails: carWash);
      if (response is CarWash) {
        emit(const OnboadSuccess(message: "Car Wash Added Successfully!"));
      } else {
        emit(OnboardError(message: response));
      }
    } catch (e) {
      emit(OnboardError(message: e.toString()));
    }
  }

  Future<CarWash> _ImageResolver(CarWash carWash, Emitter<OnboardState> emit) async {
    if (carWash.vendor_images_files != null) {
      List<FileUploadResponse> vendorImages = [];
      for (var i = 0; i < carWash.vendor_images_files!.length; i++) {
        final file = carWash.vendor_images_files![i];
        final response = await vendorRepo.uploadFile(file);
        if (response is FileUploadResponse) {
          vendorImages.add(response);
        } else {
          emit(OnboardError(message: response));
          throw Exception(response);
        }
      }
      carWash.vendor_images = vendorImages;
    }
    if (carWash.kyc!.gst_certificate_file != null) {
      final response = await vendorRepo.uploadFile(carWash.kyc!.gst_certificate_file!);
      if (response is FileUploadResponse) {
        carWash.kyc!.gst_certificate = response.id;
      } else {
        emit(OnboardError(message: response));
        throw Exception(response);
      }
    }
    return carWash;
  }
}
