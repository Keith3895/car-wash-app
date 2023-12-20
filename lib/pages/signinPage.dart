import 'package:car_wash/services/FieldValidators.dart';
import 'package:car_wash/widgets/passwordField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<SignIn> {
  var _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/Splash Screen.png"), fit: BoxFit.fill)),
      child: Container(
          child: SingleChildScrollView(
        child: LoginBackdrop(context),
      )),
    );
  }

  Widget LoginBackdrop(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color(0xE7F6F5F5), borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            _formSection(),
            SizedBox(height: 10),
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
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                onPressed: () {
                  _submit();
                },
              ),
            ),
            SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Color(0xE72D0C57), fontWeight: FontWeight.w700, fontSize: 15),
                )),
          ]),
    );
  }

  Widget _formSection() {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              _emailField(),
              SizedBox(height: 10),
              _passwordField(),
              SizedBox(height: 10),
              _loginIcons(),
              RichText(
                text: TextSpan(
                  text: '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Forgot your password?',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('The button is clicked!');
                          },
                        style: TextStyle(
                          color: Color(0xFF6200EE),
                        )),
                  ],
                ),
              )
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
        SizedBox(width: 25),
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/facebook.png'),
            onPressed: () => _externalLogin('facebook')),
        SizedBox(width: 25),
        IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: Image.asset('assets/icons/linkedin.png'),
            onPressed: () => _externalLogin('linkedin'))
      ],
    );
  }

  Widget _emailField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: const Text(
            "Email Address",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12, color: Color(0xe79586a8)),
          ),
        ),
        TextFormField(
          key: const Key('email'),
          decoration: const InputDecoration(
              labelText: "Email Address",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(height: .8, color: Color(0xe72D0C57), fontSize: 15),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xe7D9D0E3))),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(13)),
          validator: (value) => FieldValidators.validateEmail(value.toString()),
          onSaved: (value) {
            setState(() {
              _username = value.toString();
            });
          },
        ),
      ],
    );
  }

  Widget _passwordField() {
    return PasswordField(
        fieldKey: Key('password'),
        labelText: "Password",
        validator: (value) => FieldValidators.validatePassword(value.toString()),
        onSaved: (value) {
          setState(() {
            _password = value.toString();
          });
        });
  }

  void _externalLogin(provider) async {
    // var loginResp = await AuthController.authenticate(provider);
    // if (loginResp['statusCode'] >= 200 && loginResp['statusCode'] <= 210) {
    Navigator.pushNamed(context, '/home/');
    // }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // var out = await AuthController.login(_username, _password);
      // if (out['statusCode'] >= 200 && out['statusCode'] <= 210) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
      Navigator.pushNamed(context, '/base/');
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(out['body']!['error_description'])));
    }
    // } else {
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text('Invalid Email or Password')));
    // }
  }
}
