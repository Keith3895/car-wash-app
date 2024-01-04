import 'package:car_wash/repos/authRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.authRepo) : super(LogoutInitial());
  final AuthRepo authRepo;
  Future<void> logout() async {
    emit(LogoutLoading());
    final (isLogout, message) = await authRepo.logout();
    if (isLogout) {
      emit(LogoutSuccess(message: message));
    } else {
      emit(LogoutFailure(message: message));
    }
  }
}
