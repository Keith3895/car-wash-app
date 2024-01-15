import 'dart:convert';
import 'dart:io';

import 'package:car_wash/models/car_wash.dart';
import 'package:car_wash/services/auth_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class VendorRepo {
  http.Client? client;
  VendorRepo({this.client}) {
    client ??= http.Client();
  }

  // Add car wash Details
  Future<dynamic> addCarWashDetails({required CarWash carWashDetails}) async {
    var message = "";
    String accessToken = await AuthService.instance.getAccessToken();
    final url = Uri.parse("http://10.0.2.2:8000/api/vendor/");
    try {
      http.Response response = await client!.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          },
          body: utf8.encode(json.encode(carWashDetails.toJson())));
      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return CarWash.fromJson(responseBody);
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

  Future<dynamic> uploadFile(PlatformFile file) async {
    // call to upload file to server
    var message = "";
    final url = Uri.parse("http://10.0.2.2:8000/api/vendor/vendor-document/");
    String accessToken = await AuthService.instance.getAccessToken();
    try {
      var mimeTypeData = lookupMimeType(file.name);

      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('file', file.path as String,
          contentType: MediaType.parse(mimeTypeData ?? 'application/octet-stream')));
      request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      });
      var response = await request.send();
      if (response.statusCode == 201) {
        final respStr = await response.stream.bytesToString();
        final responseBody = jsonDecode(respStr);

        return FileUploadResponse.fromJson(responseBody);
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
