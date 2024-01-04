import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Splash Screen.png"), fit: BoxFit.fitHeight)),
      child: Container(
        child: carwashBackdrop(context),
      ),
    );
  }

  Widget carwashBackdrop(BuildContext context) {
    ButtonStyle buttonStyle = const ButtonStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))));
    return Container(
      height: 600,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color(0xE7F6F5F5), borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            const Text(
              "one-stop solution for finding and booking the best car wash services in town. Discover, compare, and choose from a wide range of professional car wash services, all at your fingertips. Let's give your car the shine it deserves!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, color: Color(0xE72D0C57)),
            ),
            SizedBox(
              width: 350,
              height: 55,
              child: ElevatedButton(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xE70BCE83),
                  ),
                ),
                child: const Text("ORDER NOW",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, '/base');
                },
              ),
            ),
            SizedBox(
                width: 350,
                height: 55,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    style: buttonStyle,
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(
                          color: Color(0xE72D0C57), fontWeight: FontWeight.w700, fontSize: 15),
                    ))),
            SizedBox(
                width: 350,
                height: 55,
                child: TextButton(
                    style: buttonStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: const Text(
                      "VENDOR LOGIN",
                      style: TextStyle(
                          color: Color(0xE72D0C57), fontWeight: FontWeight.w700, fontSize: 15),
                    )))
          ]),
    );
  }
}
