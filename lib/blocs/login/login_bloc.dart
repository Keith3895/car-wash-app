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
    on<AddUserType>((event, emit) async => addUserType(event, emit));
  }
  Future login(LoginMethod loginMethod, Emitter<LoginState> emit,
      {InitiateEmailSignIn? event}) async {
    emit(loginMethod.loadingState);
    final UserDetails? data;
    if (loginMethod == LoginMethod.email) {
      data =
          await authRepo.signInWithEmailAndPassword(email: event!.email, password: event.password);
    } else {
      data = await authRepo.signInWithGoogle();
    }
    if (data is UserDetails) {
      emit(const LoginSuccess(message: "Login Successful"));
      if (data.user_type == null) {
        emit(const NoUserType(message: "Login Successful"));
      }

      // await authService.updateCurrentUser(data.$1!);
    } else {
      emit(const LoginError(message: "Login Failed"));
    }
  }

  Future addUserType(AddUserType event, Emitter<LoginState> emit) async {
    UserDetails userDetails = authService.currentUser!;
    userDetails.user_type = event.userType;
    final data = await authRepo.updateUserDetails(userDetails);
    if (data is UserDetails) {
      emit(const AddUserTypeSuccess(message: "User type Modified."));
      // await authService.updateCurrentUser(data.$1!);
    } else {
      emit(const AddUserTypeError(message: "User type not saved."));
    }
  }
}
