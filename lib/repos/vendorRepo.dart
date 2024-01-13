import 'dart:convert';
import 'dart:io';

import 'package:car_wash/models/car_wash.dart';
import 'package:car_wash/services/auth_service.dart';
import 'package:http/http.dart' as http;

class VendorRepo {
  http.Client? client;
  VendorRepo({this.client}) {
    if (this.client == null) {
      this.client = http.Client();
    }
  }

  // Add car wash Details
  Future addCarWashDetails({required CarWash carWashDetails}) async {
    var message = "";
    final url = Uri.parse("http://10.0.2.2:8000/api/vendor/");
    try {
      http.Response response = await client!.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
            // HttpHeaders.authorizationHeader: 'Bearer ${AuthService.instance.accessToken}'
          },
          body: utf8.encode(json.encode(carWashDetails.toJson())));
      if (response.statusCode == 201) {
        return true;
      } else {
        message = "Something went wrong on the backend!";
      }
    } on SocketException catch (e) {
      message = e.message;
    } catch (e) {
      print(e);
      message = "Something went wrong!";
    }
    return message;
  }
}
