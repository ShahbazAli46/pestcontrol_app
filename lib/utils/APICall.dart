import 'dart:io';

import 'package:accurate/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class APICall {
  Future<bool> checkInternetConnection() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }


  Future<Map<String, dynamic>> makeRequest(
      String method,
      String url, {
        dynamic data,
        bool useToken = false,
        bool isFormData = false,
        File? imageFile,
        String? imageName,
      }) async {
    if (!await checkInternetConnection()) {
      await showNoInternetDialog();
      return makeRequest(
        method,
        url,
        data: data,
        useToken: useToken,
        isFormData: isFormData,
        imageFile: imageFile,
        imageName: imageName,
      );
    }

    print(url);

    if (imageFile != null) {
      // Handle multipart request with image
      var request = http.MultipartRequest(method, Uri.parse(url));

      if (useToken) {
        final token = await LoginResponseStorage.getToken();
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Add image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          imageName ?? 'image',
          imageFile.path,
        ),
      );

      // Add other form fields if they exist
      if (data != null) {
        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }

      var response = await request.send();
      final res = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 204) {
        return jsonDecode(res);
      } else {
        print('Error response: $res');
        return jsonDecode(res);
      }
    } else {
      // Original request handling
      var headers = {
        'Content-Type': isFormData ? 'multipart/form-data' : 'application/json',
      };

      if (useToken) {
        final token = await LoginResponseStorage.getToken();
        headers['Authorization'] = 'Bearer $token';
      }

      var request = http.Request(method, Uri.parse(url));

      if (data != null) {
        if (isFormData) {
          request.bodyFields = data;
        } else {
          request.body = jsonEncode(data);
        }
      }

      print(request.body);
      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 204) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        final res = await response.stream.bytesToString();
        print('Error response: $res');
        return jsonDecode(res);
      }
    }
  }



  Future<Map<String, dynamic>> postDataWithTokenWithImage(
      String url,
      Map<String, String> data,
      File imageFile,
      String imageName,
      ) async {
    return makeRequest(
      'POST',
      url,
      data: data,
      useToken: true,
      isFormData: true,
      imageFile: imageFile,
      imageName: imageName,
    );
  }





  Future<Map<String, dynamic>> postData(String url, dynamic data) async {
    return makeRequest('POST', url, data: data);
  }

  Future<dynamic> fetchData(String url) async {
    return makeRequest('GET', url);
  }

  Future<dynamic> postFormData(String url, dynamic data) async {
    return makeRequest('POST', url, data: data, isFormData: true);
  }

  Future<dynamic> postFormDataWithToken(String url, dynamic data) async {
    return makeRequest('POST', url, data: data, useToken: true, isFormData: true);
  }

  Future<Map<String, dynamic>> getDataWithToken(String url) async {
    return makeRequest('GET', url, useToken: true);
  }

  Future<dynamic> deleteDataWithToken(String url) async {
    return makeRequest('DELETE', url, useToken: true);
  }

  Future<dynamic> getUserById(String url) async {
    return makeRequest('GET', url, useToken: true);
  }

  Future<dynamic> updateFormDataWithToken(String url, dynamic data) async {
    return makeRequest('POST', url, data: data, useToken: true, isFormData: true, );
  }

  Future<dynamic> postDataWithToken(String url, dynamic data, ) async {
    return makeRequest('POST', url, data: data, useToken: true, isFormData : false);
  }

  Future<void> showNoInternetDialog() async {
    return showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please check your internet connection and try again.'),
          actions: <Widget>[
            TextButton(
              child: Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}