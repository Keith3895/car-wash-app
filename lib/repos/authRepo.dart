import 'dart:convert';
import 'dart:io';

import 'package:car_wash/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:car_wash/models/user_details.dart';

class AuthRepo {
  http.Client? client;
  AuthRepo({this.client}) {
    client ??= http.Client();
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
        final responseBody = jsonDecode(response.body);
        AuthService.instance.accessToken = responseBody['access'];
        AuthService.instance.refreshToken = responseBody['refresh'];
        var a = UserDetails.fromJson(responseBody['user']);
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
    GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: "809668854772-4subgvumos805dne5c05vt40tgdurcmg.apps.googleusercontent.com",
        scopes: [
          "https://www.googleapis.com/auth/userinfo.email",
          "https://www.googleapis.com/auth/userinfo.profile",
          "openid"
        ],
        forceCodeForRefreshToken: true);
    var userData = await googleSignIn.signIn();
    await googleSignIn.currentUser?.clearAuthCache();
    // userData = await _googleSignIn.signInSilently(reAuthenticate: true);
    var googleKey = await userData?.authentication;
    return _signinToBackendWithGoogle(
        token: googleKey?.idToken, access_token: googleKey?.accessToken);
  }

  Future<UserDetails?> _signinToBackendWithGoogle({required token, required access_token}) async {
    String message;
    final url = Uri.parse("http://10.0.2.2:8000/api/auth/google/");
    final tokenObject = {"access_token": access_token, "id_token": token};
    try {
      http.Response response = await client!.post(url,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: utf8.encode(json.encode(tokenObject)));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        AuthService.instance.accessToken = responseBody['access'];
        AuthService.instance.refreshToken = responseBody['refresh'];
        var a = UserDetails.fromJson(responseBody['user']);
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
    return null;
  }

  Future<(bool, String)> logout() async {
    String accessToken = await AuthService.instance.getAccessToken();
    String message;
    final url = Uri.parse("http://10.0.2.2:8000/api/auth/logout/");
    try {
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      };
      http.Response response = await client!.post(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['detail'].isNotEmpty
            ? (true, responseBody['detail'] as String)
            : (false, responseBody['detail'] as String);
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

  Future<UserDetails?> updateUserDetails(UserDetails userDetails) async {
    String accessToken = await AuthService.instance.getAccessToken();
    String message;
    final url = Uri.parse("http://10.0.2.2:8000/api/auth/user/update/");
    try {
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      };
      http.Response response = await client!.patch(
        url,
        headers: headers,
        body: utf8.encode(json.encode(userDetails.toJson())),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        AuthService.instance.updateCurrentUser(UserDetails.fromJson(responseBody));
        return UserDetails.fromJson(responseBody);
      } else {
        message = "Something went wrong on the backend.";
      }
    } on SocketException catch (e) {
      message = e.message;
    } catch (e) {
      message = "Something went wrong!";
    }
    return null;
  }

  Future<String> refreshToken(String refreshToken) async {
    String message;
    String refreshToken0 = AuthService.instance.refreshToken;
    final url = Uri.parse("http://10.0.2.2:8000/api/auth/token/refresh/");
    try {
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await client!.post(
        url,
        headers: headers,
        body: utf8.encode(json.encode({"refresh": refreshToken0})),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // AuthService.instance.refreshToken = _responseBody['refresh'];
        return responseBody['access'];
      } else {
        message = "Something went wrong on the backend.";
      }
    } on SocketException catch (e) {
      message = e.message;
    } catch (e) {
      message = "Something went wrong!";
    }
    return message;
  }
}
