import 'dart:developer';

import 'package:bikerr_partner_app/src/modules/auth/login/login.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/sql_db_services.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  late final bmc = Get.find<BaseController>();
  final userIdCntrl = TextEditingController().obs;
  final userNameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final mobNumberCntrl = TextEditingController().obs;
  final imagePath = "".obs;

  final isLoggingOut = false.obs;
  final isProfileUpdate = false.obs;

  final profileListData = [
    {
      "icon": lockOutlineIcon,
      "name": "Change Password",
    },
    {
      "icon": shareOutlineIcon,
      "name": "Share",
    },
    {
      "icon": docOutlineIcon,
      "name": "Terms of Service",
    },
    {
      "icon": docOutlineIcon,
      "name": "Terms of Uses",
    },
    {
      "icon": docOutlineIcon,
      "name": "Privacy Policy",
    },
    {
      "icon": docOutlineIcon,
      "name": "Request Account Deletion",
    },
  ];

  insertValues() async {
    userIdCntrl.value.text = bmc.hc.userDetailsData.first["user_id"];
    userNameCntrl.value.text = bmc.hc.userDetailsData.first["user_name"];
    emailCntrl.value.text = bmc.hc.userDetailsData.first["user_email"];
    mobNumberCntrl.value.text = bmc.hc.userDetailsData.first["user_number"];
  }

  updateUserProfile() async {
    var response = await HttpService.post(
      "profile-update",
      bodyTag: {
        "user_name": "",
        "user_id": "",
        "email": "",
        "mobile_number": "",
        "image": "", //file type
      },
      headerData: {'Authorization': 'Bearer ${Traccar.apiToken.value}'},
      isLoading: isProfileUpdate,
    );
    log("$response");
  }

  updateUserData({
    required int id,
    required String userId,
    required String userName,
    required String email,
    required String mobileNumber,
    required String image,
  }) async {
    await SqlDBService.sqlDBServiceinstance.updateUserDetails(
      id: id,
      userId: userId,
      userName: userName,
      email: email,
      mobileNumber: mobileNumber,
      image: image,
    );
    await bmc.hc.getUserDataFromDb();
    var response = await HttpService.post(
      "profile-update",
      bodyTag: {
        "user_name": userName,
        "user_id": userId,
        "email": email,
        "mobile_number": mobileNumber,
        "image": image, //file type
      },
      headerData: {'Authorization': 'Bearer ${Traccar.apiToken.value}'},
      isLoading: isProfileUpdate,
    );
    log("$response", name: "sdlfhasd");
  }

  pickUserImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? result = await picker.pickImage(source: ImageSource.gallery);
    imagePath.value = result!.path;
    imagePath.refresh();
    int id = await SharedPreferencesServices.getIntData(key: "user_id_int") ?? 0;

    await updateUserData(
      id: id,
      userId: userIdCntrl.value.value.text,
      userName: userNameCntrl.value.value.text,
      email: emailCntrl.value.value.text,
      mobileNumber: mobNumberCntrl.value.value.text,
      image: imagePath.value,
    );
  }

  logout() async {
    isLoggingOut.value = true;
    await Traccar.logout();
    await SharedPreferencesServices.clearSharedPrefData();
    await SqlDBService.sqlDBServiceinstance.clearDb();
    isLoggingOut.value = false;
    Get.offAll(() => const LoginScreen());
  }
}
