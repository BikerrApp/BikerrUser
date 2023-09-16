// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/strings/url.dart';
import '../../../base/base_class.dart';

class LoginController extends GetxController {
  final userId = TextEditingController().obs;
  final password = TextEditingController().obs;
  final isLogin = false.obs;

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
      await SharedPreferencesServices.setBoolData(
          key: "isLoggedIn", value: true);
      log("${await SharedPreferencesServices.getBoolData(key: "isLoggedIn")}",
          name: "hfsdjhjfhsjdf");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var body = {
        'user_id': userId.value.value.text.trim().trimLeft().trimRight(),
        'password': password.value.value.text.trim().trimLeft().trimRight(),
      };
      log('___token $body');

      var responseBikkerLoginApi = await http.post(
          Uri.parse(
            '${commonBaseUrl}login',
          ),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      log('___token ${responseBikkerLoginApi.statusCode}');
      var data = jsonDecode(responseBikkerLoginApi.body);
      if (data['status_code'] == 200) {
        print('___token $data');
        print('____token ${responseBikkerLoginApi.body}');

        await prefs.setString('currentToken', data['data']['token']);
        Get.offAll(() => const BaseClass());
      } else {
        getToast(data['message']);
      }
      // log("RESPONSE -> ${response?.body} ");
    } else {}
  }
}
