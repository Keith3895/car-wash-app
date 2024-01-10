import 'package:car_wash/pages/onboarding/widgets/page_one.dart';
import 'package:car_wash/pages/onboarding/widgets/page_three.dart';
import 'package:car_wash/pages/onboarding/widgets/page_two.dart';
import 'package:car_wash/widgets/AppBar.dart';
import 'package:car_wash/widgets/ElevatedButton.dart';
import 'package:car_wash/widgets/cardButton.dart';
import 'package:car_wash/widgets/inputField.dart';
import 'package:car_wash/widgets/inputLabel.dart';
import 'package:car_wash/widgets/regularButtion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminOnboarding extends StatefulWidget {
  @override
  _AdminOnboardingState createState() => _AdminOnboardingState();
}

class _AdminOnboardingState extends State<AdminOnboarding> {
  int _pageNumber = 0;
  final car_wash_name = TextEditingController();
  final phone_number = TextEditingController();
  final email = TextEditingController();
  final gstn = TextEditingController();
  final PAN = TextEditingController();
  final registered_company_name = TextEditingController();
  final bank_account_number = TextEditingController();
  final IFSC = TextEditingController();
  final UPID = TextEditingController();
  final address = TextEditingController();

  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageNumber);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Setup Profile'),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _progressBar(),
                SizedBox(
                  height: 20,
                ),
                Text("Car Wash Details",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary)),
                _pageView(),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      children: [
                        if (_pageNumber == 1)
                          RegularButton(
                            text: 'Skip',
                            onPressed: () {
                              _pageController.animateToPage(
                                _pageNumber = 2,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              setState(() {
                                _pageNumber = 2;
                              });
                            },
                            key: const Key('skip Button'),
                          ),
                        CustomElevatedButton(
                          text: _pageNumber == 3 ? 'Finish' : 'Next',
                          onPressed: () {
                            if (_pageNumber < 3) {
                              _pageController.animateToPage(
                                _pageNumber + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              setState(() {
                                _pageNumber++;
                              });
                            } else {
                              print(car_wash_name.text);
                              print(phone_number.text);
                              print(email.text);
                              print(gstn.text);
                              print(PAN.text);
                              print(registered_company_name.text);
                              Navigator.pushNamed(context, '/admin');
                            }
                          },
                          key: const Key('next Button'),
                        ),
                        if (_pageNumber != 0)
                          RegularButton(
                            text: 'Back',
                            onPressed: () {
                              _pageController.animateToPage(
                                _pageNumber - 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              setState(() {
                                _pageNumber--;
                              });
                            },
                            key: const Key('back Button'),
                          ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  Widget _progressBar() {
    return LinearProgressIndicator(
      value: _pageNumber / 3,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
    );
  }

  Widget _pageView() {
    return SizedBox(
      height: 500,
      child: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _pageNumber = page;
          });
        },
        children: [
          PageOne(
            key: const Key('Page One'),
            car_wash_name: car_wash_name,
            phone_number: phone_number,
            email: email,
          ),
          SingleChildScrollView(
              child: PageTwo(
            key: const Key('Page Two'),
            gstn: gstn,
            PAN: PAN,
            registered_company_name: registered_company_name,
            bank_account_number: bank_account_number,
            IFSC: IFSC,
            UPID: UPID,
          )),
          SingleChildScrollView(
              child: PageThree(
            key: const Key('Page Three'),
            address: address,
          )),
          SingleChildScrollView(child: _pageFour())
        ],
      ),
    );
  }

  Widget _pageFour() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabels(
                label: "Car Wash Name",
              ),
              InputField(
                  key: const Key('Car Wash Name'),
                  ftIcon: "\uf5e4",
                  labelText: "Car Wash Name",
                  skipLabel: true,
                  controller: car_wash_name,
                  enabled: false),
              InputLabels(label: "Address"),
              InputField(
                key: const Key('Address'),
                ftIcon: "\uf601",
                labelText: "Address",
                skipLabel: true,
                controller: address,
                enabled: false,
              ),
              InputLabels(label: "Contact Info"),
              InputField(
                key: const Key('phone number'),
                labelText: "Phone Number",
                skipLabel: true,
                ftIcon: "\uf095",
                controller: phone_number,
                enabled: false,
              ),
              InputField(
                key: const Key('email'),
                labelText: "Email",
                skipLabel: true,
                ftIcon: "\uf1fa",
                controller: email,
                enabled: false,
              ),
              InputLabels(label: "Services"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(spacing: 22, runSpacing: 10, children: [
                  // show images
                  cardButton(onPressed: () {}),
                ]),
              )
            ]));
  }
}
