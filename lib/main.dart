import 'package:car_wash/routes/base.dart';
import 'package:car_wash/routes/signin.dart';
import 'package:flutter/material.dart';
import 'routes/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: 'Flutter Navigation',
    theme: ThemeData(
      // This is the theme of your application.
      primarySwatch: Colors.green,
    ),
    // home: FirstRoute(),
    initialRoute: '/landing',
    routes: {
      '/landing': (context) => LandingRoute(),
      '/signin': (context) => SignInRoute(),
      '/base': (context) => BasePath()
    },
  ));
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: TextButton(
          // color: Colors.blueGrey,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back'),
        ),
      ),
    );
  }
}
