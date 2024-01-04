import 'package:car_wash/blocs/login/login_bloc.dart';
import 'package:car_wash/cubits/internet/internet_cubit.dart';
import 'package:car_wash/cubits/logout/logout_cubit.dart';
import 'package:car_wash/models/user_details.dart';
import 'package:car_wash/repos/authRepo.dart';
import 'package:car_wash/routes/router.dart';
import 'package:car_wash/services/auth_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDetailsAdapter());
  await Hive.openBox('auth_service_box');
  AuthService.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(
    connectivity: Connectivity(),
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  Connectivity connectivity;
  AppRouter appRouter;
  MyApp({
    Key? key,
    required this.connectivity,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [RepositoryProvider<AuthRepo>(create: (context) => AuthRepo())],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: AuthService.instance),
          ],
          child: MultiBlocProvider(
              providers: [
                BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(
                    authService: AuthService.instance,
                    authRepo: context.read<AuthRepo>(),
                  ),
                ),
                BlocProvider<InternetCubit>(
                    create: (context) => InternetCubit(connectivity: connectivity)),
                BlocProvider(
                  create: (context) => LogoutCubit(context.read<AuthRepo>()),
                ),
              ],
              child: MaterialApp(
                title: 'Car Wash',
                theme: ThemeData(
                  primarySwatch: Colors.green,
                ),
                onGenerateRoute: appRouter.onGenerateRoute,
                // home: BlocListener<InternetCubit, InternetState>(
                //   listener: (context, state) {
                //     if (state is InternetDisconnected) {
                //       // _showSnackBar(context, "No Internet Access!", 100000);
                //     } else if (state is InternetConnected) {
                //       // _showSnackBar(context, "Internet Connected!", 4000);
                //     }
                //   },
                // )
              )),
        ));
  }

  _showSnackBar(context, message, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: duration),
        action: SnackBarAction(
          label: 'close',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }
}
