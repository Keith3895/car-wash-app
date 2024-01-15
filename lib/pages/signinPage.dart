import 'package:car_wash/blocs/login/login_bloc.dart';
import 'package:car_wash/widgets/loginWidgets/loginBackdrop.dart';
import 'package:car_wash/widgets/loginWidgets/login_form.dart';
import 'package:car_wash/widgets/loginWidgets/vendorConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/Splash Screen.png"), fit: BoxFit.fill)),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushNamed(context, '/base');
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is NoUserType) {
              VendorConfirmationModal(context);
            }
          },
          child: Container(
              child: SingleChildScrollView(
            child: _loginBackdrop(context),
          )),
        ));
  }

  Widget _loginBackdrop(BuildContext context) {
    return LoginBackdrop(children: [
      const LoginFormSection(),
      const SizedBox(height: 10),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Color(0xE72D0C57), fontWeight: FontWeight.w700, fontSize: 15),
          )),
    ]);
  }
}
