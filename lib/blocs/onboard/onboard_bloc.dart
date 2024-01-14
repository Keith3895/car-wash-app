import 'dart:math';

import 'package:car_wash/models/car_wash.dart';
import 'package:car_wash/repos/vendorRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final VendorRepo vendorRepo;
  OnboardBloc({required this.vendorRepo}) : super(OnboardInitial()) {
    on<AddCarWashDetails>((event, emit) async => addCarWash(emit, event: event));
    on<getVendorDetails>((event, emit) async => emit(NoVendorDetails()));
  }

  addCarWash(Emitter<OnboardState> emit, {AddCarWashDetails? event}) async {
    // emit OnboardLoading();

    CarWash _carWash = event!.carWashDetails;
    _carWash = await _ImageResolver(_carWash, emit);
    try {
      final response = await vendorRepo.addCarWashDetails(carWashDetails: _carWash);
      if (response is CarWash) {
        emit(OnboadSuccess(message: "Car Wash Added Successfully!"));
      } else {
        emit(OnboardError(message: response));
      }
    } catch (e) {
      emit(OnboardError(message: e.toString()));
    }
  }

  Future<CarWash> _ImageResolver(CarWash _carWash, Emitter<OnboardState> emit) async {
    if (_carWash.vendor_images_files != null) {
      List<FileUploadResponse> _vendor_images = [];
      for (var i = 0; i < _carWash.vendor_images_files!.length; i++) {
        final _file = _carWash.vendor_images_files![i];
        final _response = await vendorRepo.uploadFile(_file);
        if (_response is FileUploadResponse) {
          _vendor_images.add(_response);
        } else {
          emit(OnboardError(message: _response));
          throw Exception(_response);
        }
      }
      _carWash.vendor_images = _vendor_images;
    }
    if (_carWash.kyc!.gst_certificate_file != null) {
      final _response = await vendorRepo.uploadFile(_carWash.kyc!.gst_certificate_file!);
      if (_response is FileUploadResponse) {
        _carWash.kyc!.gst_certificate = _response.id;
      } else {
        emit(OnboardError(message: _response));
        throw Exception(_response);
      }
    }
    return _carWash;
  }
}
