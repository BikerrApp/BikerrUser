// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:bikerr_partner_app/src/models/user_model.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../base/base_class.dart';

class LoginController extends GetxController {
  final userId = TextEditingController().obs;
  final password = TextEditingController().obs;
  final isLogin = false.obs;
  final isBikerLogin = false.obs;
  final notificationToken = "".obs;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  validateLogin() {
    if (userId.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("User Id cannot be empty");
    if (password.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("Password cannot be empty");
    return loginTap();
  }

  loginTap() async {
    var responseData = await Traccar.login(
      userId: userId.value.value.text.trim().trimLeft().trimRight(),
      password: password.value.value.text.trim().trimLeft().trimRight(),
      loading: isLogin,
    );

    var response = jsonDecode(responseData!.body);

    if (responseData.statusCode == 200) {
      final user = User.fromJson(response);
      updateUserInfo(user, user.id.toString());
      await SharedPreferencesServices.setIntData(
        key: "userId",
        value: response["id"],
      );
      await SharedPreferencesServices.setBoolData(
        key: "isLoggedIn",
        value: true,
      );
      await SharedPreferencesServices.setStringData(
        key: "password",
        value: password.value.value.text.trim().trimLeft().trimRight(),
      );
      var bikerResponse = await loginOnBikerServer();

      if (bikerResponse["status_code"] == 200) {
        await SharedPreferencesServices.setStringData(
          key: "apiToken",
          value: bikerResponse["data"]["token"],
        );
        await SharedPreferencesServices.setStringData(
          key: "fcmToken",
          value: bikerResponse["user_detail"]["fcm_token"],
        );
        // updateUserInfo(user, user.id.toString());
        Traccar.apiToken.value = bikerResponse["data"]["token"];
        Get.offAll(() => const BaseClass());
      }
    } else {}
  }

  loginOnBikerServer() async {
    var response = await HttpService.post(
      "login",
      bodyTag: {
        'user_id': userId.value.value.text.trim().trimLeft().trimRight(),
        'password': password.value.value.text.trim().trimLeft().trimRight(),
      },
      headerData: {'Content-Type': 'application/json'},
      isLoading: isLogin,
    );

    return response;
  }

  eeupdateUserInfo(User user, String id) async {
    var t =
        await SharedPreferencesServices.getStringData(key: "fcmToken") ?? "";
    var oldToken = t.toString().split(",");
    var tokens = t;

    if (user.attributes!.containsKey("notificationTokens")) {
      if (!oldToken.contains(notificationToken.value)) {
        t = "${notificationToken.value},$tokens";
      }
    } else {
      t = notificationToken.value;
    }

    String userReq = json.encode(user.toJson());

    Traccar.updateUser(userReq, id).then((value) => {});
  }

  Future<String> getFCMToken() async {
    try {
      await messaging.requestPermission();
      final settings = await messaging.getNotificationSettings();
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        String? token = Platform.isAndroid
            ? await messaging.getToken()
            : await messaging.getAPNSToken();

        return token ?? "";
      } else {
        throw PlatformException(
          code: 'UNAUTHORIZED',
          message: 'User has not authorized push notifications.',
        );
      }
    } catch (e) {
      return e.toString();
    }
  }

  updateUserInfo(User user, String id) async {
    String fcmToken = await getFCMToken();

    if (user.attributes!["notificationTokens"] != "") {
      var oldToken =
          user.attributes!["notificationTokens"].toString().split(",");

      var tokens = user.attributes!["notificationTokens"];
      if (user.attributes!.containsKey("notificationTokens")) {
        if (!oldToken.contains(fcmToken)) {
          user.attributes!["notificationTokens"] = "$fcmToken,$tokens";
        }
      } else {
        user.attributes!["notificationTokens"] = fcmToken;
      }
    } else {
      user.attributes = HashMap();
      user.attributes?["notificationTokens"] = fcmToken;
    }

    String userReq = json.encode(user.toJson());

    Traccar.updateUser(userReq, id).then((value) => {});
  }
}
