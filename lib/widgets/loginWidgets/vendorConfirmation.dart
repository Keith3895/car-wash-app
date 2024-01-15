import 'package:car_wash/blocs/login/login_bloc.dart';
import 'package:car_wash/widgets/ElevatedButton.dart';
import 'package:car_wash/widgets/inputLabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

VendorConfirmationModal(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      bool toggleState = true;
      return Container(
        height: 200,
        color: const Color(0xE7F8F8F8),
        child: const VendorConfirmation(),
      );
    },
  );
}

class VendorConfirmation extends StatefulWidget {
  const VendorConfirmation({super.key});

  @override
  _VendorConfirmationState createState() => _VendorConfirmationState();
}

class _VendorConfirmationState extends State<VendorConfirmation> {
  bool toggleState = true;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const InputLabels(label: "Are you a vendor?"),
              Switch.adaptive(
                // This bool value toggles the switch.
                value: toggleState,

                inactiveTrackColor: const Color(0xFEE2CBFF),
                activeColor: Colors.white,
                activeTrackColor: Theme.of(context).colorScheme.secondary,

                onChanged: (bool value) {
                  setState(() {
                    toggleState = value;
                  });
                  // This is called when the user toggles the switch.
                },
              ),
            ],
          ),
          CustomElevatedButton(
              key: const Key('submit'),
              text: "Submit",
              onPressed: () {
                context.read<LoginBloc>().add(AddUserType(userType: toggleState ? 2 : 1));
                Navigator.pop(context);
              }),
        ]));
  }
}
