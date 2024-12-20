// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class NetworkUtils {
//   static final NetworkUtils _instance = NetworkUtils._internal();
//
//   factory NetworkUtils() {
//     return _instance;
//   }
//
//   NetworkUtils._internal();
//
//   Future<bool> checkInternetConnection() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   Future<String> getToken() async {
//     // Implement your token retrieval logic here
//     // For example, you might use SharedPreferences or another storage mechanism
//     return 'your_token_here';
//   }
//
//   Future<dynamic> _makeRequest(String method, String url, {Map<String, String>? headers, dynamic body}) async {
//     if (!await checkInternetConnection()) {
//       await showNoInternetDialog();
//       return _makeRequest(method, url, headers: headers, body: body);
//     }
//
//     headers ??= {};
//     headers['Authorization'] = 'Bearer ${await getToken()}';
//
//     try {
//       late http.Response response;
//
//       switch (method) {
//         case 'GET':
//           response = await http.get(Uri.parse(url), headers: headers);
//           break;
//         case 'POST':
//           response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
//           break;
//       // Add other HTTP methods as needed
//         default:
//           throw Exception('Unsupported HTTP method: $method');
//       }
//
//       return _processResponse(response);
//     } catch (e) {
//       throw Exception('Failed to perform $method request: $e');
//     }
//   }
//
//   Future<dynamic> get(String url, {Map<String, String>? headers}) async {
//     return _makeRequest('GET', url, headers: headers);
//   }
//
//   Future<dynamic> post(String url, {Map<String, String>? headers, dynamic body}) async {
//     return _makeRequest('POST', url, headers: headers, body: body);
//   }
//
//   dynamic _processResponse(http.Response response) {
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('HTTP request failed with status: ${response.statusCode}');
//     }
//   }
//
//   Future<void> showNoInternetDialog() async {
//     return showDialog(
//       context: navigatorKey.currentContext!,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('No Internet Connection'),
//           content: Text('Please check your internet connection and try again.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Retry'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// // Assuming you have a global navigator key defined somewhere in your app
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();