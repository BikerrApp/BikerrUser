// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';

import 'package:bikerr_partner_app/src/modules/auth/login/login.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordController extends GetxController {
  final passCntrl = TextEditingController().obs;
  final conPassCntrl = TextEditingController().obs;

  final isObscure = false.obs;
  final isSetPassword = false.obs;
  final isRegister = false.obs;

  validatePassword() {
    if (passCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("Password is required");
    if (conPassCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("Confirm Password is required");
    if (passCntrl.value.value.text.trim() !=
        conPassCntrl.value.value.text.trim())
      return getToast("Password and Confirm Password must be equal");
    return setPassword();
  }

  registerUserOnServer() async {
    var response = await HttpService.post(
      "users",
      isLoading: isRegister,
      isServer: true,
      bodyTag: {
        "name": Get.arguments["user_name"],
        "email": Get.arguments["user_id"],
        "phone": Get.arguments["mobile_number"],
        "password": passCntrl.value.value.text.trim().trimLeft().trimRight(),
        "twelveHourFormat": "true",
      },
    );
    log("$response", name: "register response");
  }

  setPassword() async {
    var response = await HttpService.post(
      "password-set",
      isLoading: isSetPassword,
      bodyTag: {
        'password': passCntrl.value.value.text.trim().trimLeft().trimRight(),
        'password_confirmation':
            conPassCntrl.value.value.text.trim().trimLeft().trimRight(),
      },
      headerData: {'Authorization': 'Bearer ${Get.arguments["token"]}'},
    );
    var traccarResponse = await registerUserOnServer();
    log("$traccarResponse", name: "trac response");
    log("$response", name: "set response");
    if (response["response"] == "success") {
      Get.offAll(() => const LoginScreen());
    }
  }
}
