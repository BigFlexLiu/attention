import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
  }
  debugPrint("hello world");
}

Future<void> showNotificationWithTimer(
    int secondsRemaining, flutterLocalNotificationsPlugin) async {
  var androidDetails = AndroidNotificationDetails(
    'channel id',
    'channel name',
    channelDescription: 'channel description',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
    usesChronometer: true,
    when: DateTime.now().millisecondsSinceEpoch + secondsRemaining * 1000,
  );
  var platformDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Timer', // Title
    'Timer is running', // Body
    platformDetails,
  );
}

void startTimer(int totalSeconds) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  Timer.periodic(const Duration(seconds: 1), (timer) {
    int secondsRemaining = totalSeconds - timer.tick;
    if (secondsRemaining <= 0) {
      timer.cancel();
      flutterLocalNotificationsPlugin.cancelAll();
      showNotificationWithTimer(
          0, flutterLocalNotificationsPlugin); // To notify when the timer ends
    } else {
      showNotificationWithTimer(
          secondsRemaining, flutterLocalNotificationsPlugin);
    }
  });
}
