// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController {
  final userIdCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;

  final isForgot = false.obs;

  forgotPassword() async {
    if (userIdCntrl.value.value.text.trim().isEmpty)
      return getToast("Please enter a Valid User ID");
    if (emailCntrl.value.value.text.trim().isEmpty)
      return getToast("Please enter a Valid email");
    else {
      var res = await HttpService.post(
        "password/email",
        bodyTag: {
          "user_id": userIdCntrl.value.value.text.trim(),
          "email": emailCntrl.value.value.text.trim(),
        },
        isLoading: isForgot,
      );
      if (res["status_code"] == 200) {
        getToast("${res["message"]}");
        userIdCntrl.value.clear();
        emailCntrl.value.clear();
      } else {
        getToast("Something went wrong, please try again");
      }
    }
  }
}
