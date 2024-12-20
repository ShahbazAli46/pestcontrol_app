import 'package:accurate/AccountantDashboard/AccountantDashboardScreen.dart';
import 'package:accurate/NotificationService.dart';
import 'package:accurate/UserRepository.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/firebase_options.dart';
import 'package:accurate/sales_man/salesManDashboard.dart';
import 'package:accurate/superadmin/SuperAdminDashboard.dart';
import 'package:accurate/user/login.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/FirebaseApi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'jsonModels/LoginResponse.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
LoginResponse? userObj;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  await NotificationService().init;
  String? token = await NotificationService().getDeviceToken();
  print(token);
  final loginResponse = await LoginResponseStorage.getLoginResponse();
  userObj = loginResponse;

  Widget home;
  home = Login();

  final isLoggedIn = await LoginResponseStorage.getToken() != null;
  if (isLoggedIn) {
    if (loginResponse?.data?.roleId != null) {
      final roleId = loginResponse?.data?.roleId ?? "";
      home = NotificationInitWrapper(
          child: UiHelper.goToUserDashboardAsPerUserRole(int.parse("${roleId}"))
      );
    }
  } else {
    home = NotificationInitWrapper(child: Login());
  }



  runApp(
    GetMaterialApp(
      navigatorKey: navigatorKey,
      home: home,
      defaultTransition: Transition.fade,
      initialBinding: BindingsBuilder(() {}),
    ),
  );
}
