// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/pages/category_page/categories_screen.dart';
import 'package:positify_project/pages/login_screen/loginView.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';
import 'package:cron/cron.dart';

import '../pages/daily_quote_reminder.dart';

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final corn = Cron();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
    //_localNotificationService.getNotificationAppLaunchDetails();
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required int seconds}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        DateTime.now().add(Duration(seconds: seconds)),
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showWeekScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime dt,
      required int seconds}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        dt,
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  Future<void> showPeriodicNotificationsWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload,
      required RepeatInterval Repeated}) async {
    final details = await _notificationDetails();
    await _localNotificationService.periodicallyShow(
        id, title, body, Repeated, details,
        androidAllowWhileIdle: true, payload: payload);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    // print('id $id');
  }

  void onSelectNotification(String? payload) async {
    // print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
      //payload is the category which is displayed on the notification
      //U can navigate the user to any specific screen and pass the payload as constructor to use it further
        
      Get.to(CategoriesScreen());
    }
  }

  void excutingworkmanager(int id, String title, String body, String payload,
      String type, int hour, int min, DateTime upcomingdate) async {
    print("data of body $body");
    print("data of title $title");

    await _localNotificationService.cancelAll().then((value) async {
      final details = await _notificationDetails();
      if (type == "everyday") {
        print("everyday notification is executed");
        _localNotificationService.zonedSchedule(
            id,
            title,
            body,
            tz.TZDateTime.from(
                DateTime(upcomingdate.year, upcomingdate.month,
                        upcomingdate.day, hour, min, 0, 0, 0)
                    .add(const Duration(seconds: 7)),
                // DateTime(upcomingdate.year, upcomingdate.month,
                //     upcomingdate.day, hour, min, 0).add(const Duration(seconds: 7)),
                tz.local),
            details,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.wallClockTime,
            androidAllowWhileIdle: true,
            payload: payload,
            matchDateTimeComponents: DateTimeComponents.time);
      } else {
        print("weekly notification for date ${upcomingdate.day}");
        _localNotificationService.zonedSchedule(
            id,
            title,
            body,
            tz.TZDateTime.from(
                    DateTime(upcomingdate.year, upcomingdate.month,
                        upcomingdate.day, hour, min, 0),
                    tz.local)
                .add(const Duration(seconds: 10)),
            details,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.wallClockTime,
            androidAllowWhileIdle: true,
            payload: payload,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
      }
    });

    // _localNotificationService.showWeeklyAtDayAndTime(
    //     id,
    //     title,
    //     body,
    //     Day.wednesday,
    //     Time(DateTime.now().hour, DateTime.now().minute + 1, 0),
    //     details,
    //     payload: payload);
    print("notification is executed");

    // showPeriodicNotificationsWithPayload(
    //     id: id, title: title, body: body, payload: payload);
  }
}
