// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';

import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../set_password/set_password.dart';

class SignUpController extends GetxController {
  final userIdCntrl = TextEditingController().obs;
  final userNameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final mobNumberCntrl = TextEditingController().obs;
  final passwordCntrl = TextEditingController().obs;

  final isSignup = false.obs;

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  signupValidation() {
    if (userIdCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("User Id Cannot Be empty");
    if (userNameCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("User Name Cannot Be empty");
    if (emailCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("Email Cannot Be empty");
    if (!isValidEmail(
        emailCntrl.value.value.text.trim().trimLeft().trimRight()))
      return getToast("Email is not valid");
    if (mobNumberCntrl.value.value.text.trim().trimLeft().trimRight().isEmpty)
      return getToast("Mobile Number Cannot Be empty");
    return signupTap();
  }

  signupTap() async {
    var response = await HttpService.post(
      "register",
      isLoading: isSignup,
      bodyTag: {
        'user_id': userIdCntrl.value.value.text.trim().trimLeft().trimRight(),
        'user_name':
            userNameCntrl.value.value.text.trim().trimLeft().trimRight(),
        'email': emailCntrl.value.value.text.trim().trimLeft().trimRight(),
        'mobile_number':
            mobNumberCntrl.value.value.text.trim().trimLeft().trimRight(),
      },
      isServer: false,
    );

    log("$response", name: "register");

    if (response["response"] == "error") {
      getToast("${response["message"]}");
    } else {
      await SharedPreferencesServices.setStringData(
        key: 'currentToken',
        value: response['data']['token'],
      );
      Get.to(() => const SetPasswordScreen(), arguments: {
        'user_id': userIdCntrl.value.value.text.trim().trimLeft().trimRight(),
        'user_name':
            userNameCntrl.value.value.text.trim().trimLeft().trimRight(),
        'email': emailCntrl.value.value.text.trim().trimLeft().trimRight(),
        'mobile_number':
            mobNumberCntrl.value.value.text.trim().trimLeft().trimRight(),
      });
      getToast("Account registered successfully. Please set your password.");
    }
  }
}
