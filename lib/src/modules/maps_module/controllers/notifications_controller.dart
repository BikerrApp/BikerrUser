import 'dart:convert';
import 'dart:developer';

import 'package:bikerr_partner_app/src/models/notification_model.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final notificationsType = <NotificationsType>[].obs;
  final selectedNotifications = <NotificationModel>[].obs;
  final isLoading = true.obs;
  final isEnableLoading = false.obs;
  final isRemoveLoading = false.obs;

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

    String username =
        await SharedPreferencesServices.getStringData(key: 'email') ?? "";
    String password =
        await SharedPreferencesServices.getStringData(key: 'password') ?? "";
    String basicAuth =
        "Basic ${base64.encode(utf8.encode('$username:$password'))}";

    var response = await HttpService.postServer("notifications",
        isLoading: isEnableLoading,
        bodyTag: json.encode(body),
        headerData: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json'
        });

    log("$response");

    getSelectedNotifications();
  }

  removeNotification(int id, int index) async {
    String username =
        await SharedPreferencesServices.getStringData(key: 'email') ?? "";
    String password =
        await SharedPreferencesServices.getStringData(key: 'password') ?? "";
    String basicAuth =
        "Basic ${base64.encode(utf8.encode('$username:$password'))}";

    var response = await HttpService.deleteServer(
      "$id",
      basicAuth,
      isLoading: isRemoveLoading,
    );
    log("$response");

    notificationsType[index].enabled = false;
    notificationsType.refresh();
    // getSelectedNotifications();
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
