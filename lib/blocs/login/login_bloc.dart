import 'package:car_wash/models/user_details.dart';
import 'package:car_wash/repos/authRepo.dart';
import 'package:car_wash/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

enum LoginMethod {
  email(title: "Email", loadingState: EmailLoginLoading()),
  google(title: "Google", loadingState: GoogleLoginLoading());

  final String title;
  final LoginState loadingState;
  const LoginMethod({required this.title, required this.loadingState});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthService authService;
  AuthRepo authRepo;

  LoginBloc({required this.authService, required this.authRepo}) : super(LoginInitial()) {
    on<InitiateEmailSignIn>((event, emit) async => login(LoginMethod.email, emit, event: event));
    on<InitiateGoogleSignIn>(
      (event, emit) async => login(LoginMethod.google, emit),
    );
  }
  Future login(LoginMethod loginMethod, Emitter<LoginState> emit,
      {InitiateEmailSignIn? event}) async {
    emit(loginMethod.loadingState);
    final data;
    if (loginMethod == LoginMethod.email) {
      data =
          await authRepo.signInWithEmailAndPassword(email: event!.email, password: event.password);
    } else {
      data = await authRepo.signInWithGoogle();
    }
    if (data is UserDetails) {
      // await authService.updateCurrentUser(data.$1!);
      emit(const LoginSuccess(message: "Login Successful"));
    } else {
      emit(LoginError(message: "Login Failed"));
    }
  }
}
