// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'dart:developer';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/base_class.dart';

class LoginController extends GetxController {
  final userId = TextEditingController().obs;
  final password = TextEditingController().obs;
  final isLogin = false.obs;
  final isBikerLogin = false.obs;

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
    log(responseData!.body, name: "asdgsragase");
    var response = jsonDecode(responseData.body);
    log("$response", name: "login response");
    if (responseData.statusCode == 200) {
      await SharedPreferencesServices.setIntData(
        key: "userId",
        value: response["id"],
      );
      await SharedPreferencesServices.setBoolData(
        key: "isLoggedIn",
        value: true,
      );
      var bikerResponse = await loginOnBikerServer();
      log("${bikerResponse["data"]["token"]}", name: "vkgfiytfjkhfkf");
      if (bikerResponse["status_code"] == 200) {
        await SharedPreferencesServices.setStringData(
          key: "apiToken",
          value: bikerResponse["data"]["token"],
        );
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
    log("$response", name: "responseBikkerLogin");
    return response;
  }
}
