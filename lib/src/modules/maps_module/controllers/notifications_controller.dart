import 'dart:developer';

import 'package:bikerr_partner_app/src/models/notification_model.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final notificationsType = <NotificationsType>[].obs;
  final selectedNotifications = <NotificationModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() async {
    await getNotificationsType();
    super.onInit();
  }

  getNotificationsType() async {
    var nt = await Traccar.getNotificationTypes(loading: isLoading);
    for (var i = 0; i < nt.length; i++) {
      notificationsType.add(NotificationsType.fromJson(nt[i]));
      notificationsType.refresh();
    }
    log("$nt", name: "jdflkjhasjkfhjkas");
    await getSelectedNotifications();
  }

  getSelectedNotifications() async {
    var sn = await Traccar.getNotifications(loading: isLoading);
    log("$sn", name: "kjfdkjfkdjfi");
    for (int i = 0; i < sn.length; i++) {
      selectedNotifications.add(NotificationModel.fromJson(sn[i]));
      selectedNotifications.refresh();
    }
    for (int i = 0; i < notificationsType.length; i++) {
      for (int j = 0; j < selectedNotifications.length; j++) {
        if (notificationsType[i].type.toString() ==
            selectedNotifications[j].type.toString()) {
          notificationsType[i].enabled = true;
          notificationsType[i].id = selectedNotifications[j].id;
          notificationsType.refresh();
        }
      }
    }
  }

  enableNotification(String type, int index) async {
    var body = {
      "id": index,
      "type": type.toString(),
      "always": true,
      "notificators": "firebase,web",
      "calendarId": 0,
      "attributes": {}
    };

    await Traccar.setNotifications(loading: isLoading, body: body)
        .then((value) {
      getSelectedNotifications();
    });
  }

  removeNotification(int id, int index) async {
    await Traccar.removeNotifications(loading: isLoading, id: id).then((value) {
      notificationsType[index].enabled = false;
      getSelectedNotifications();
    });
  }
}

class NotificationsType {
  String? type;
  int? id;
  bool? enabled;

  NotificationsType({this.type, this.enabled, this.id});

  factory NotificationsType.fromJson(Map<String, dynamic> json) =>
      NotificationsType(
          type: json["type"], enabled: json["enabled"], id: json["id"]);

  Map<String, dynamic> toJson() => {"type": type, 'enabled': enabled, "id": id};
}
