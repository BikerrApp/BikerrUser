// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';

import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login/login.dart';

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
    var response =
        await HttpService.postServer("users", isLoading: isRegister, bodyTag: {
      "name": Get.arguments["user_name"],
      "email": Get.arguments["user_id"],
      "phone": Get.arguments["mobile_number"],
      "password": passCntrl.value.value.text.trim().trimLeft().trimRight(),
      "twelveHourFormat": "true",
    }, headerData: {
      'content-type': 'application/json; charset=utf-8',
    });
    return response;
    log("$response", name: "register response");
  }

  setPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //    print('${prefs.getStringList('token')}');
    var token = prefs.getString('currentToken');
    print('____password ${{
      'password': passCntrl.value.value.text.trim().trimLeft().trimRight(),
      'password_confirmation':
          conPassCntrl.value.value.text.trim().trimLeft().trimRight(),
    }}');

    var response = await HttpService.post(
      "password-set",
      isLoading: isSetPassword,
      bodyTag: {
        'password': passCntrl.value.value.text.trim().trimLeft().trimRight(),
        'password_confirmation':
            conPassCntrl.value.value.text.trim().trimLeft().trimRight(),
      },
      headerData: {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json; charset=utf-8',
      },
    );
    print('____password $response');

    if (response['status_code'] == 200) {
      print('____password $response');
      var traccarResponse = await registerUserOnServer();
      log(traccarResponse.statusCode.toString(), name: "trac response");
      log("$response", name: "set response");
      //TODO bikerr. in pass-
      if (traccarResponse.statusCode.toString() == "200") {
        Get.offAll(() => const LoginScreen());
      }
    } else {
      getToast(response['message']);
    }
  }
}
