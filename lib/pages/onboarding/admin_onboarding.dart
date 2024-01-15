import 'package:car_wash/blocs/onboard/onboard_bloc.dart';
import 'package:car_wash/models/car_wash.dart';
import 'package:car_wash/pages/onboarding/widgets/page_one.dart';
import 'package:car_wash/pages/onboarding/widgets/page_three.dart';
import 'package:car_wash/pages/onboarding/widgets/page_two.dart';
import 'package:car_wash/widgets/AppBar.dart';
import 'package:car_wash/widgets/ElevatedButton.dart';
import 'package:car_wash/widgets/cardButton.dart';
import 'package:car_wash/widgets/inputField.dart';
import 'package:car_wash/widgets/inputLabel.dart';
import 'package:car_wash/widgets/regularButtion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOnboarding extends StatefulWidget {
  const AdminOnboarding({super.key});

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
  var addressObj;
  var gstCertificate;
  final AdharNumber = TextEditingController();
  List<PlatformFile> filesList = [];
  late final PageController _pageController;

  final _formKey = GlobalKey<FormState>();

  final _page2Key = GlobalKey<FormState>();

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
        appBar: const CustomAppBar('Setup Profile'),
        body: SingleChildScrollView(
            child: BlocListener<OnboardBloc, OnboardState>(
          listener: (context, state) {
            if (state is OnboadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.pushNamedAndRemoveUntil(context, '/base', (route) => false);
            } else if (state is OnboardError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          // child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _progressBar(context),
                const SizedBox(
                  height: 20,
                ),
                Text("Car Wash Details",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary)),
                _pageView(context),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        if (_pageNumber == 1)
                          RegularButton(
                            text: 'Skip',
                            onPressed: () {
                              _pageController.animateToPage(
                                _pageNumber = 2,
                                duration: const Duration(milliseconds: 500),
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
                          onPressed: onSubmitPressed,
                          key: const Key('next Button'),
                        ),
                        if (_pageNumber != 0)
                          RegularButton(
                            text: 'Back',
                            onPressed: () {
                              _pageController.animateToPage(
                                _pageNumber - 1,
                                duration: const Duration(milliseconds: 500),
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
          // ),
        )));
  }

  onSubmitPressed() {
    if (_pageNumber == 1) {
      if (_page2Key.currentState!.validate()) {
        _page2Key.currentState!.save();
      }
    }
    if (_pageNumber < 3) {
      _pageController.animateToPage(
        _pageNumber + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setState(() {
        _pageNumber++;
      });
    } else {
      CarWash carWash = CarWash.fromflatStructure(
          company_name: car_wash_name.text,
          phone_number: phone_number.text,
          email: email.text,
          address: addressObj,
          bank_account_number: bank_account_number.text,
          IFSC: IFSC.text,
          UPID: UPID.text,
          gstn: gstn.text,
          PAN: PAN.text,
          vendor_images_files: filesList,
          gst_certificate_file: gstCertificate,
          adhar_number: AdharNumber.text,
          registered_company_name: registered_company_name.text);
      context.read<OnboardBloc>().add(AddCarWashDetails(carWashDetails: carWash));
    }
  }

  Widget _progressBar(BuildContext context) {
    return LinearProgressIndicator(
      value: _pageNumber / 3,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
    );
  }

  Widget _pageView(BuildContext context) {
    return SizedBox(
        height: 500,
        child: NotificationListener<OnSubmitEmitter>(
          onNotification: (OnSubmitEmitter notification) {
            print(notification.value);
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // notification.callback();
            }
            return true;
          },
          child: Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _pageNumber = page;
                  });
                },
                children: [
                  SingleChildScrollView(
                      child: PageOne(
                    filesList: filesList,
                    key: const Key('Page One'),
                    car_wash_name: car_wash_name,
                    phone_number: phone_number,
                    email: email,
                    onfilePicked: (value) {
                      setState(() {
                        filesList = filesList + value;
                      });
                    },
                  )),
                  SingleChildScrollView(
                      child: PageTwo(
                          gstn: gstn,
                          PAN: PAN,
                          registered_company_name: registered_company_name,
                          bank_account_number: bank_account_number,
                          IFSC: IFSC,
                          UPID: UPID,
                          gstCertificate: gstCertificate,
                          key: const Key('Page Two'),
                          formKey: _page2Key,
                          AdharNumber: AdharNumber,
                          onFormSubmit: (value) {
                            setState(() {
                              gstCertificate = value;
                            });
                          })),
                  SingleChildScrollView(
                      child: PageThree(
                    onAddressSet: (value) {
                      addressObj = value;
                    },
                    key: const Key('Page Three'),
                    address: address,
                  )),
                  SingleChildScrollView(child: _pageFour())
                ],
              )),
        ));
  }

  Widget _pageFour() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InputLabels(
                label: "Car Wash Name",
              ),
              InputField(
                  key: const Key('Car Wash Name'),
                  ftIcon: "\uf5e4",
                  labelText: "Car Wash Name",
                  skipLabel: true,
                  controller: car_wash_name,
                  enabled: false),
              const InputLabels(label: "Address"),
              InputField(
                key: const Key('Address'),
                ftIcon: "\uf601",
                labelText: "Address",
                skipLabel: true,
                controller: address,
                enabled: false,
              ),
              const InputLabels(label: "Contact Info"),
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
              const InputLabels(label: "Services"),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(spacing: 22, runSpacing: 10, children: [
                  // show images
                  cardButton(onPressed: () {}),
                ]),
              )
            ]));
  }
}
