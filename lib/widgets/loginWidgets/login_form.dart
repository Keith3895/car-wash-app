import 'package:car_wash/blocs/login/login_bloc.dart';
import 'package:car_wash/services/FieldValidators.dart';
import 'package:car_wash/widgets/inputField.dart';
import 'package:car_wash/widgets/passwordField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  _LoginFormSectionState createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  void _onLogIn() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      _loginBloc.add(InitiateEmailSignIn(email: email, password: password));
    } else {
      return;
    }
  }

  Future<void> _externalLogin(String provider) async {
    if (provider == 'gcp') {
      _loginBloc.add(InitiateGoogleSignIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = context.read<LoginBloc>();
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              _emailField(),
              const SizedBox(height: 10),
              _passwordField(),
              const SizedBox(height: 10),
              _loginIcons(),
              RichText(
                text: TextSpan(
                  text: '',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Forgot your password?',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('The button is clicked!');
                          },
                        style: const TextStyle(
                          color: Color(0xFF6200EE),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                  child: const Text("Sign In",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                  onPressed: () {
                    _onLogIn();
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _loginIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Image.asset('assets/icons/gmail.png'), onPressed: () => _externalLogin('gcp')),
        const SizedBox(width: 25),
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/facebook.png'),
            onPressed: () => _externalLogin('facebook')),
        const SizedBox(width: 25),
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/linkedin.png'),
            onPressed: () => _externalLogin('linkedin'))
      ],
    );
  }

  Widget _emailField() {
    return InputField(
      controller: _emailController,
      fieldKey: const Key('email'),
      labelText: "Email Address",
      validator: (value) => FieldValidators.validateEmail(value.toString()),
      onFieldSubmitted: (_) => _onLogIn(),
    );
  }

  Widget _passwordField() {
    return PasswordField(
      controller: _passwordController,
      fieldKey: const Key('password'),
      labelText: "Password",
      validator: (value) => FieldValidators.validatePassword(value.toString()),
      onFieldSubmitted: (_) => _onLogIn(),
    );
  }
}
