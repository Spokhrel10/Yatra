import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
    'Remainder',
    'Remainder',
    priority: Priority.high,
    importance: Importance.max,
    ticker: 'remainder',
    // sound: RawResourceAndroidNotificationSound('notify'),
  );

  @override
  void onInit() {
    tz.initializeTimeZones();

    initializing();
    _showNotificationsAfterSecond();
    super.onInit();
  }

  void initializing() async {
    await AndroidFlutterLocalNotificationsPlugin()
        .areNotificationsEnabled()
        .then((value) {
      if (!value!) {
        AndroidFlutterLocalNotificationsPlugin().requestPermission();
      }
    });

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void _showNotificationsAfterSecond() async {
    await notificationAfterSec(
      duration: const Duration(seconds: 200),
    );
  }

  Future<void> notificationAfterSec({required Duration duration}) async {
    NotificationDetails notify = NotificationDetails(
      android: androidNotificationDetails,
    );

    late var tzdatetime =
        tz.TZDateTime.from(DateTime.now().add(duration), tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'Hot Offers!',
      'Book your tickets now!',
      tzdatetime,
      notify,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  // Future? onSelectNotification(String payLoad) {
  //   if (payLoad != null) {
  //     print(payLoad);
  //   }
  //   return null;
  //   // we can set navigator to navigate another screen
  // }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: const Text("Okay")),
      ],
    );
  }
}
