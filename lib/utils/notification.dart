import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationManager {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future initialize() async {
    tz.initializeTimeZones();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('drawable/ic_stat_logo');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _notification.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      onNotifications.add(payload as String?);
    });
  }

  static Future _notificationDetails() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channelId', 'Tabemashou',
        channelDescription: 'channelDescription',
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    return NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
  }

  static Future<void> scheduleDailyNotification(int notificationId,
      TimeOfDay scheduledTime, String title, String message) async {
    /// Request permission to send notifications
    var notificationStatus = await Permission.notification.status;
    var scheduleStatus = await Permission.scheduleExactAlarm.status;
    if (!notificationStatus.isGranted) {
      await Permission.notification.request();
    }
    if (!scheduleStatus.isGranted) {
      await Permission.scheduleExactAlarm.request();
    }
    try {
      await _notification.zonedSchedule(notificationId, title, message,
          format(scheduledTime), await _notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.alarmClock,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> cancelNotification(int notificationId) async {
    await _notification.cancel(notificationId);
  }

  static tz.TZDateTime format(TimeOfDay scheduledTime) {
    /// Date and time format
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDateTime = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, scheduledTime.hour, scheduledTime.minute, 0);
    return scheduledDateTime.isBefore(now)
        ? scheduledDateTime.add(const Duration(days: 1))
        : scheduledDateTime;
  }
}