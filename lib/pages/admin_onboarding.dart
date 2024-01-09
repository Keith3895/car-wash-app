import 'package:car_wash/widgets/AppBar.dart';
import 'package:car_wash/widgets/ElevatedButton.dart';
import 'package:car_wash/widgets/filePicker.dart';
import 'package:car_wash/widgets/inputField.dart';
import 'package:car_wash/widgets/regularButtion.dart';
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
                          text: 'Next',
                          onPressed: () {
                            if (_pageNumber < 2) {
                              _pageController.animateToPage(
                                _pageNumber + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              setState(() {
                                _pageNumber++;
                              });
                            } else {
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
          _pageOne(),
          SingleChildScrollView(child: _pageTwo()),
          _pageThree(),
        ],
      ),
    );
  }

  Widget _pageOne() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 34,
            ),
            Text("Please Enter the Name That should be displayed to the customers.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.tertiary)),
            SizedBox(
              height: 10,
            ),
            _InputLabels("Car Wash Name"),
            InputField(
              key: const Key('Car Wash Name'),
              ftIcon: "\uf5e4",
              labelText: "Car Wash Name",
              skipLabel: true,
              controller: car_wash_name,
            ),
            SizedBox(
              height: 70,
            ),
            Text("Please Enter the Contact Information that should be displayed to the customers.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.tertiary)),
            SizedBox(
              height: 10,
            ),
            _InputLabels("Contact Info"),
            InputField(
              key: const Key('phone number'),
              labelText: "Phone Number",
              skipLabel: true,
              ftIcon: "\uf095",
              controller: phone_number,
            ),
            InputField(
              key: const Key('email'),
              labelText: "Email",
              skipLabel: true,
              ftIcon: "\uf1fa",
              controller: email,
            )
          ],
        ));
  }

  Widget _pageTwo() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 10,
              children: [
                InputField(
                  key: const Key('GSTN'),
                  labelText: "GSTN",
                  controller: gstn,
                ),
                InputField(
                  key: const Key('PAN'),
                  labelText: "PAN",
                  controller: PAN,
                ),
                InputField(
                  key: const Key('Registered Company Name'),
                  labelText: "Registered Company Name",
                  controller: registered_company_name,
                ),
                InputField(
                  key: const Key('Bank Account Number'),
                  labelText: "Bank Account Number",
                  controller: bank_account_number,
                ),
                InputField(
                  key: const Key('IFSC'),
                  labelText: "IFSC",
                  controller: IFSC,
                ),
                InputField(
                  key: const Key('UPI ID'),
                  labelText: "UPI ID",
                  controller: UPID,
                ),
              ],
            ),
            _InputLabels("Car Wash Images"),
            FilePickerWidget(
              key: const Key('File Picker'),
              onFilePicked: (result) {
                print(result);
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }

  Widget _pageThree() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Add your Car Wash',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Add your car wash to the app by filling in the details below. 3 ',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 20,
          ),
          // Image.asset('assets/Onboarding2.png'),
        ],
      ),
    );
  }

  Widget _InputLabels(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(label,
          textAlign: TextAlign.left,
          style: TextStyle(
              letterSpacing: -0.41,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary)),
    );
  }
}
