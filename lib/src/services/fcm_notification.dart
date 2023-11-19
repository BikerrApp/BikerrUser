import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification.dart';

class FCMNotificationWithLocal {
  LocalNotification localNoti = LocalNotification();
  FCMNotificationWithLocal() {
    LocalNotification.initLocalPlugin();
    fcmNotificationInsilize();
  }

  fcmNotificationInsilize() async {
    log("fcm ins", name: "hddkdj");

    await FirebaseMessaging.instance.getInitialMessage().then(
          (message) async {},
        );
    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) async {
        LocalNotification.showNotification(
            desc: "${message.data}", payload: "");
      },
    );
    //  3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {},
    );
  }
}
