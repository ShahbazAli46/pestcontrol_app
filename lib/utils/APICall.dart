import 'dart:io';

import 'package:accurate/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class APICall {
  Future<bool> checkInternetConnection() async {
    try {
      // First, check connectivity status
      final connectivityResult = await Connectivity().checkConnectivity();

      // If no connectivity, return false immediately
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }

      // Additional check to verify actual internet access
      try {
        final result = await InternetAddress.lookup('google.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        return false;
      }
    } catch (e) {
      // Handle any unexpected errors
      print('Error checking internet connection: $e');
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



  Future<dynamic> sendMultipartRequest(
      String method,
      String url,
      File imageFile, {
        bool useToken = true,
        Map<String, dynamic>? data,
        String? imageName,
      }) async {
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
        if (value is List) {
          // Handle array fields differently
          for (var i = 0; i < value.length; i++) {
            request.fields['${key}[$i]'] = value[i].toString();
          }
        } else {
          request.fields[key] = value.toString();
        }
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




  Future<Map<String, dynamic>> postDataWithTokenWithImage2(
      String url,
      Map<dynamic, dynamic> data,
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


  Future<Map<String, dynamic>> postDataWithTokenWithImageAndArrays(
      String url,
      Map<String, dynamic> data,
      File imageFile, {
        String? imageName,
      }) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (!await checkInternetConnection()) {
      await showNoInternetDialog();
      return postDataWithTokenWithImageAndArrays(
        url,
        data,
        imageFile,
        imageName: imageName,
      );
    }

    // Add authorization token
    final token = await LoginResponseStorage.getToken();
    request.headers['Authorization'] = 'Bearer $token';

    // Add image file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        imageName ?? 'signature_img',
        imageFile.path,
      ),
    );

    // Add other form fields if they exist
    if (data != null) {
      data.forEach((key, value) {
        if (value is List) {
          // Handle arrays of objects
          if (value.isNotEmpty && value[0] is Map) {
            for (var i = 0; i < value.length; i++) {
              Map<String, dynamic> item = value[i];
              item.forEach((itemKey, itemValue) {
                request.fields['$key[$i][$itemKey]'] = itemValue.toString();
              });
            }
          }
          // Handle simple arrays (like tm_ids and pest_found_ids)
          else {
            for (var i = 0; i < value.length; i++) {
              request.fields['$key[$i]'] = value[i].toString();
            }
          }
        } else {
          request.fields[key] = value.toString();
        }
      });
    }

    print('Request fields: ${request.fields}'); // For debugging

    var response = await request.send();
    final res = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 204) {
      return jsonDecode(res);
    } else {
      print('Error response: $res');
      return jsonDecode(res);
    }
  }

  Future<Map<String, dynamic>> postDataWithTokenAndArrays(
      String url,
      Map<String, dynamic> data) async {

    print(url);
    if (!await checkInternetConnection()) {
      await showNoInternetDialog();
      return postDataWithTokenAndArrays(url, data);
    }

    // Get authorization token
    final token = await LoginResponseStorage.getToken();

    // Prepare form data
    Map<String, String> formFields = {};

    // Process the data map
    if (data != null) {
      data.forEach((key, value) {
        if (value is List) {
          // Handle arrays of objects
          if (value.isNotEmpty && value[0] is Map) {
            for (var i = 0; i < value.length; i++) {
              Map<String, dynamic> item = value[i];
              item.forEach((itemKey, itemValue) {
                formFields['$key[$i][$itemKey]'] = itemValue.toString();
              });
            }
          }
          // Handle simple arrays (like tm_ids and pest_found_ids)
          else {
            for (var i = 0; i < value.length; i++) {
              formFields['$key[$i]'] = value[i].toString();
            }
          }
        } else {
          formFields[key] = value.toString();
        }
      });
    }

    print('Form fields: $formFields'); // For debugging

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formFields,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return jsonDecode(response.body);
      } else {
        print('Error response: ${response.body}');
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw e;
    }
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

  Future<List<Map<String, dynamic>>> fetchArrayData(
      String url, {
        bool useToken = false,
      }) async {
    if (!await checkInternetConnection()) {
      await showNoInternetDialog();
      return fetchArrayData(url, useToken: useToken);
    }

    var headers = {
      'Content-Type': 'application/json',
    };

    if (useToken) {
      final token = await LoginResponseStorage.getToken();
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      var response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Parse the response string into a List<dynamic>
        final List<dynamic> decodedResponse = jsonDecode(responseString);

        // Convert each item in the list to Map<String, dynamic>
        return decodedResponse.map((item) =>
        Map<String, dynamic>.from(item)
        ).toList();
      } else {
        print('Error response: $responseString');
        throw HttpException('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching array data: $e');
      throw HttpException('Failed to fetch data: $e');
    }
  }

  /// Fetches data with authentication from an API endpoint that returns an array
  Future<List<Map<String, dynamic>>> getArrayDataWithToken(String url) async {
    return fetchArrayData(url, useToken: true);
  }



  Future<dynamic> sendMultipartRequestWithImages(
      String method,
      String url, {
        bool useToken = true,
        Map<String, dynamic>? data,
        List<File>? images,
        String imagesFieldName = 'images',
      }) async {
    if (!await checkInternetConnection()) {
      await showNoInternetDialog();
      return sendMultipartRequestWithImages(
        method,
        url,
        useToken: useToken,
        data: data,
        images: images,
        imagesFieldName: imagesFieldName,
      );
    }
    print(data);
    var request = http.MultipartRequest(method, Uri.parse(url));

    if (useToken) {
      final token = await LoginResponseStorage.getToken();
      request.headers['Authorization'] = 'Bearer $token';
    }

    // Add images to the request if provided
    if (images != null && images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath(
            '$imagesFieldName[$i]',
            images[i].path,
          ),
        );
      }
    }

    // Add other form fields if they exist
    if (data != null) {
      data.forEach((key, value) {
        if (value is List) {
          // Handle array fields
          for (var i = 0; i < value.length; i++) {
            request.fields['${key}[$i]'] = value[i].toString();
          }
        } else {
          request.fields[key] = value.toString();
        }
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