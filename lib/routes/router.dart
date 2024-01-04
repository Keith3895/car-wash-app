import 'package:car_wash/routes/base.dart';
import 'package:car_wash/routes/landing.dart';
import 'package:car_wash/routes/signin.dart';
import 'package:car_wash/services/auth_service.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/landing':
        return MaterialPageRoute(
          builder: (_) => const LandingRoute(),
        );
      case '/signin':
        return MaterialPageRoute(
          builder: (_) => const SignInRoute(),
        );
      case '/base':
        return MaterialPageRoute(
          builder: (_) => const BasePath(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            print("------------------");
            print(AuthService.instance.isLoggedIn);
            return AuthService.instance.isLoggedIn ? const BasePath() : const LandingRoute();
          },
        );
    }
  }
}
