import 'package:car_wash/pages/basePage.dart';
import 'package:flutter/material.dart';

class BasePath extends StatelessWidget {
  const BasePath({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: basePage(),
    );
  }
}
