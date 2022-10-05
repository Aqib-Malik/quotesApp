import 'dart:async';

import 'package:flutter/material.dart';
import 'package:positify_project/notifications/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");
void callbackDispatcher() {
  // LocalNotificationService().excutingworkmanager(duration, id, title, body, payload)
  print("workmanager is executed");
}
