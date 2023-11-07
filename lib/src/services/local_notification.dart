import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initLocalPlugin() async {
    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
      defaultPresentBadge: true,
    );

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static showNotification({
    required String desc,
    required String payload,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Notifications",
      playSound: true,
      priority: Priority.max,
      setAsGroupSummary: true,
      importance: Importance.max,
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    NotificationDetails notiDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await notificationsPlugin.show(
      id,
      "Bikerr",
      desc,
      notiDetails,
      payload: payload,
    );
  }
}
