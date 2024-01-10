import 'dart:async';

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
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Future<void> main() async {
  // PermissionStatus status = await Permission.locationWhenInUse.request();

  // if (status.isGranted) {
  //   // Permission granted, proceed with your functionality
  // } else {
  //   // Permission not granted, handle accordingly
  // }
  await Hive.initFlutter();
  Hive.registerAdapter(UserDetailsAdapter());
  await Hive.openBox('auth_service_box');
  AuthService.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
    initializeMapRenderer();
  }
  runApp(MyApp(
    connectivity: Connectivity(),
    appRouter: AppRouter(),
  ));
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;
Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer = Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) => completer.complete(initializedRenderer)));
  } else {
    completer.complete(null);
  }

  return completer.future;
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
                debugShowCheckedModeBanner: false,
                title: 'Car Wash',

                theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      primary: Color(0xE72D0C57),
                      secondary: Color(0xE70BCE83),
                      tertiary: Color(0xE79586A8),
                    ),
                    fontFamily: 'SFProText',
                    scaffoldBackgroundColor: Color(0xE7F8F8F8)),
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
