import 'package:car_wash/services/FieldValidators.dart';
import 'package:car_wash/widgets/inputField.dart';
import 'package:car_wash/widgets/loginBackdrop.dart';
import 'package:car_wash/widgets/passwordField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  serverClientId: "809668854772-4subgvumos805dne5c05vt40tgdurcmg.apps.googleusercontent.com",
);

class LoginState extends State<SignIn> {
  var _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    _googleSignIn.currentUser?.clearAuthCache();
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/Splash Screen.png"), fit: BoxFit.fill)),
      child: Container(
          child: SingleChildScrollView(
        child: _loginBackdrop(context),
      )),
    );
  }

  Widget _loginBackdrop(BuildContext context) {
    return LoginBackdrop(children: [
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
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
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
            style: TextStyle(color: Color(0xE72D0C57), fontWeight: FontWeight.w700, fontSize: 15),
          )),
    ]);
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
    return InputField(
      fieldKey: const Key('email'),
      labelText: "Email Address",
      validator: (value) => FieldValidators.validateEmail(value.toString()),
      onSaved: (value) {
        setState(() {
          _username = value.toString();
        });
      },
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

  Future<void> _externalLogin(String provider) async {
    if (provider == 'gcp') {
      var userData = await _googleSignIn.signIn(); //.then((userData) {
      var googleKey = await userData?.authentication; //.then((googleKey) {
      print(googleKey?.accessToken);
      print(googleKey?.idToken);
      print(_googleSignIn.currentUser?.displayName);
      // }).catchError((err) {
      //   print('inner error');
      // });
      // print(userData);
      // }).catchError((e) {
      //   print("error");
      //   print(e);
      // });
    }
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
