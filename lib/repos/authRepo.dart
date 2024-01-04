import 'dart:convert';
import 'dart:io';

import 'package:car_wash/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:car_wash/models/user_details.dart';

class AuthRepo {
  http.Client? client;
  AuthRepo({this.client}) {
    if (this.client == null) {
      this.client = http.Client();
    }
  }

  Future<UserDetails?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    var message = "";
    try {
      final url = Uri.parse("http://10.0.2.2:8000/api/auth/login/");
      final signupObject = {
        "email": email,
        "password": password,
      };
      http.Response response = await client!.post(url,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: utf8.encode(json.encode(signupObject)));
      if (response.statusCode == 200) {
        final _responseBody = jsonDecode(response.body);
        AuthService.instance.accessToken = _responseBody['access'];
        AuthService.instance.refreshToken = _responseBody['refresh'];
        var a = UserDetails.fromJson(_responseBody['user']);
        AuthService.instance.updateCurrentUser(a);
        return a;
      } else {
        message = "Something went wrong on the backend!";
      }
    } on SocketException catch (e) {
      message = e.message;
    } catch (e) {
      print(e);
      message = "Something went wrong!";
    }
    return throw (message);
  }

  Future<UserDetails?> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
        serverClientId: "809668854772-4subgvumos805dne5c05vt40tgdurcmg.apps.googleusercontent.com",
        scopes: [
          "https://www.googleapis.com/auth/userinfo.email",
          "https://www.googleapis.com/auth/userinfo.profile",
          "openid"
        ],
        forceCodeForRefreshToken: true);
    var userData = await _googleSignIn.signIn();
    await _googleSignIn.currentUser?.clearAuthCache();
    // userData = await _googleSignIn.signInSilently(reAuthenticate: true);
    var googleKey = await userData?.authentication;
    return _signinToBackendWithGoogle(
        token: googleKey?.idToken, access_token: googleKey?.accessToken);
  }

  Future<UserDetails?> _signinToBackendWithGoogle({required token, required access_token}) async {
    var message;
    final url = Uri.parse("http://10.0.2.2:8000/api/auth/google/");
    final tokenObject = {"access_token": access_token, "id_token": token};
    try {
      http.Response response = await client!.post(url,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: utf8.encode(json.encode(tokenObject)));
      if (response.statusCode == 200) {
        final _responseBody = jsonDecode(response.body);
        AuthService.instance.accessToken = _responseBody['access'];
        AuthService.instance.refreshToken = _responseBody['refresh'];
        var a = UserDetails.fromJson(_responseBody['user']);
        AuthService.instance.updateCurrentUser(a);
        return a;
      } else {
        message = "Something went wrong on the backend.";
      }
    } on SocketException catch (e) {
      message = e.message;
    } catch (e) {
      message = "Something went wrong!";
    }
  }

  Future<(bool, String)> logout() async {
    String _accessToken = AuthService.instance.accessToken;
    String message;
    final url = Uri.parse("http://10.0.2.2:8000/api/auth/logout/");
    try {
      final _headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: _accessToken
      };
      http.Response response = await client!.post(
        url,
        headers: _headers,
      );
      if (response.statusCode == 200) {
        final _responseBody = jsonDecode(response.body);
        return _responseBody['detail'].isNotEmpty
            ? (true, _responseBody['detail'] as String)
            : (false, _responseBody['detail'] as String);
      } else {
        message = "Something went wrong on the backend.";
      }
    } on SocketException catch (e) {
      message = e.message;
    } catch (e) {
      message = "Something went wrong!";
    }
    return (false, message);
  }
}
