import 'package:accurate/AccountantDashboard/AccountantDashboardScreen.dart';
import 'package:accurate/NotificationService.dart';
import 'package:accurate/UserRepository.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/sales_man/salesManDashboard.dart';
import 'package:accurate/superadmin/SuperAdminDashboard.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'jsonModels/LoginResponse.dart';
import 'utils/APICall.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final _errorMessage = ''.obs;
  final APICall _apiCall = APICall();
  BuildContext? context;


  String get errorMessage => _errorMessage.value;

  Future<void> loginRequest(String email, String password) async {
    if (!_validateInputs(email, password)) return;
    try {
      isLoading.value = true;
      final response = await _apiCall.postData(
        Urls.login,
        {
          'email': email,
          'password': password,
        },
      );
      GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
      if (errorResponse.status == "error"){
        AlertService.showAlert("Errro", errorResponse.message ?? "");
      }
      else{
        final loginResponse = LoginResponse.fromJson(response);
        userObj = loginResponse;

        await NotificationService().init;
        await NotificationService().updateTokenOnServer();
        await LoginResponseStorage.saveLoginResponse(loginResponse);
        print("************************");
        print(loginResponse.data?.roleId);
        Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(builder: (context) => UiHelper.goToUserDashboardAsPerUserRole(loginResponse.data?.roleId ?? 0)),
              (Route<dynamic> route) => false,
        );
      }
      isLoading.value = false;
    } catch (e) {
      _errorMessage.value = 'Failed to log in. Please check ID and Password';
      print('Error parsing JSON: $e');
      AlertService.showAlert('Error', _errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs(String email, String password) {
    if (email.isEmpty) {
      AlertService.showAlert('Error', 'Please enter your email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      AlertService.showAlert('Error', 'Please enter a valid email');
      return false;
    }

    if (password.isEmpty) {
      AlertService.showAlert('Error', 'Please enter your password');
      return false;
    }

    return true;
  }
}

class LoginRequest {
  String? email;
  String? password;

  LoginRequest({this.email, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}