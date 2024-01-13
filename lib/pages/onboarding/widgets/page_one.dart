import 'package:car_wash/services/FieldValidators.dart';
import 'package:car_wash/widgets/inputField.dart';
import 'package:car_wash/widgets/inputLabel.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne(
      {Key? key, required this.car_wash_name, required this.phone_number, required this.email})
      : super(key: key);
  final TextEditingController car_wash_name;
  final TextEditingController phone_number;
  final TextEditingController email;
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  TextEditingController car_wash_name = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    car_wash_name = widget.car_wash_name;
    phone_number = widget.phone_number;
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return _pageOne(context);
  }

  Widget _pageOne(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 34,
            ),
            Text("Please Enter the Name That should be displayed to the customers.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.tertiary)),
            const SizedBox(
              height: 10,
            ),
            const InputLabels(label: "Car Wash Name"),
            InputField(
              key: const Key('Car Wash Name'),
              ftIcon: "\uf5e4",
              labelText: "Car Wash Name",
              skipLabel: true,
              controller: car_wash_name,
              validator: (value) => FieldValidators.validateName(value.toString()),
              onChanged: (value) => {OnSubmitEmitter(value).dispatch(context)},
            ),
            const SizedBox(
              height: 70,
            ),
            Text("Please Enter the Contact Information that should be displayed to the customers.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.tertiary)),
            const SizedBox(
              height: 10,
            ),
            const InputLabels(label: "Contact Info"),
            InputField(
              key: const Key('phone number'),
              labelText: "Phone Number",
              skipLabel: true,
              ftIcon: "\uf095",
              controller: phone_number,
              validator: (value) => FieldValidators.validateMobile(value.toString()),
              onFieldSubmitted: (value) => {OnSubmitEmitter(value).dispatch(context)},
            ),
            InputField(
              key: const Key('email'),
              labelText: "Email",
              skipLabel: true,
              ftIcon: "\uf1fa",
              controller: email,
              validator: (value) => FieldValidators.validateEmail(value.toString()),
            )
          ],
        ));
  }
}

class OnSubmitEmitter extends Notification {
  final value;

  OnSubmitEmitter(this.value);
}
