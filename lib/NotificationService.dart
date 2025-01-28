import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:accurate/AccountantDashboard/AccountantDashboardScreen.dart';


class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void init(BuildContext context) async {
    // Request notification permissions
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Android notification channel
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // Notification settings
      const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      final initializationSettingsIOS = DarwinInitializationSettings();
      final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
          _handleNotificationTap(context, notificationResponse);
        },
      );

      // Firebase Messaging Listeners
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _showLocalNotification(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleRemoteMessageNavigation(context, message);
      });

      // Check if app was opened from a terminated state
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _handleRemoteMessageNavigation(context, initialMessage);
      }
    }
  }

  // Show local notification when app is in foreground
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  // Handle notification tap from local notification
  void _handleNotificationTap(BuildContext context, NotificationResponse notificationResponse) {
    print("Notification tapped from local notification");
    _navigateToDashboard(context);
  }

  // Handle remote message navigation (background/terminated states)
  void _handleRemoteMessageNavigation(BuildContext context, RemoteMessage message) {
    print("Navigating from remote message ${message.data.toString()}");
    _navigateToDashboard(context);
  }

  // Common navigation method
  void _navigateToDashboard(BuildContext context) {
    // Use Navigator instead of Get for more reliable navigation
    Get.to(()=>AccountantDashboardScreen());
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (context) => AccountantDashboardScreen()),
    //       (Route<dynamic> route) => false,
    // );
  }

  // Get device token for Firebase messaging
  Future<String?> updateTokenOnServer() async {
    print("I am here in update token");
    try {
      String? token = await _fcm.getToken();
      if (token != null){
        updateToken(token ?? "");
      }

      return token;
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  void updateToken(String token) async{
    String url = Urls.baseURL + "device/token";
    String appVersion = "1.0.1";

    if(userObj != null){
      UpdateTokenRequest request = UpdateTokenRequest();
      request.appVersion = appVersion ?? "";
      request.firebaseToken = token;
      var api = APICall();
      var response = await api.postDataWithToken(url, request.toJson());
      try {
        UpdateTokenResponse updateTokenResponse = UpdateTokenResponse.fromJson(response);
        // if (updateTokenResponse.isAppActive == 1){
        //   AlertService.showUpdateAppAlert(
        //     title: "Alert",
        //     message: "App is inactive due to maintenance, please try later",
        //     onUpdatePressed: () {
        //       // Handle the "Update App" button action
        //       _launchAppStore(); // You need to implement this function to open the app store
        //     },
        //   );
        // }
        if (updateTokenResponse.appVersion != appVersion) {
          // Show an un-dismissible alert with an "Update App" button
          AlertService.showUpdateAppAlert(
            title: "Update Required",
            message: "A new version of the app is available. Please update to continue using the app.",
            onUpdatePressed: () {
              // Handle the "Update App" button action
              _launchAppStore(); // You need to implement this function to open the app store
            },
          );
        }



      } catch (e) {
        AlertService.showAlert("Alert", e.toString());
      }
    }
  }
  _launchAppStore(){

  }
}

// Background message handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}






class NotificationInitWrapper extends StatefulWidget {
  final Widget child;

  const NotificationInitWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _NotificationInitWrapperState createState() => _NotificationInitWrapperState();
}

class _NotificationInitWrapperState extends State<NotificationInitWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}



class UpdateTokenRequest {
  String? appVersion;
  String? firebaseToken;

  UpdateTokenRequest({this.appVersion, this.firebaseToken});

  UpdateTokenRequest.fromJson(Map<String, dynamic> json) {
    appVersion = json['app_version'];
    firebaseToken = json['firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_version'] = this.appVersion;
    data['firebase_token'] = this.firebaseToken;
    return data;
  }
}


class UpdateTokenResponse {
  String? status;
  String? message;
  String? appVersion;
  int? isAppActive;
  String? disableAppReason;

  UpdateTokenResponse(
      {this.status,
        this.message,
        this.appVersion,
        this.isAppActive,
        this.disableAppReason});

  UpdateTokenResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    appVersion = json['app_version'];
    isAppActive = json['is_app_active'];
    disableAppReason = json['disable_app_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['app_version'] = this.appVersion;
    data['is_app_active'] = this.isAppActive;
    data['disable_app_reason'] = this.disableAppReason;
    return data;
  }
}