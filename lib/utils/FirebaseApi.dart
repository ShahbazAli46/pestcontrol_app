import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FirebaseAPi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleBackgroundMsg(RemoteMessage body) async {
    print('title ${body.notification?.title ?? ""}');
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    // bool isLoggedIn = await SessionManager.getIsLoggedIn() ?? false;
    // if (isLoggedIn) {
    //   setupFlutterNotifications();
    //   String id = await SessionManager.getUserId() ?? "";
    //   TokenUpdateRequest request =
    //   TokenUpdateRequest(id: id, deviceToken: fcmToken ?? "");
    //   NetworkUtils().sendData(Constants.updateToken, request,
    //           (success, responseData, errorMessage) {
    //       });
    // }

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMsg);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Get.to(()=>NewOrdersList());
    });

  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'your_channel_id', // channel ID
        'your_channel_name', // channel name
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
      await FlutterLocalNotificationsPlugin().show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
      );
    }
  }


  Future<void> setupFlutterNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  }

}
