import 'package:flutter/material.dart';

class LoginBackdrop extends StatelessWidget {
  final List<Widget> children;
  const LoginBackdrop({super.key, required this.children});
  @override
  Widget build(BuildContext context) {
    List<Widget> newChildren = [
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/Icon.png")),
        ],
      ),
      const Text(
        "Car Wash App",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xE72D0C57)),
      ),
    ];
    if (children.isNotEmpty) {
      newChildren = [...newChildren, ...children];
    }
    return Container(
        height: 600,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Color(0xE7F6F5F5), borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: newChildren));
  }
}
