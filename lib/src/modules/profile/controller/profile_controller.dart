// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';
import 'dart:io';

import 'package:bikerr_partner_app/src/modules/auth/login/login.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/profile/screens/terms_and_policies_screen.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/sql_db_services.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  late final bmc = Get.find<BaseController>();
  final userIdCntrl = TextEditingController().obs;
  final userNameCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;
  final mobNumberCntrl = TextEditingController().obs;
  final imagePath = "".obs;

  final currentPassCntrl = TextEditingController().obs;
  final newPassCntrl = TextEditingController().obs;
  final conPassCntrl = TextEditingController().obs;
  final isChangePassword = false.obs;

  final isLoggingOut = false.obs;
  final isProfileUpdate = false.obs;
  final isConditionsLoading = false.obs;
  final termsAndConditions = [].obs;

  final profileListData = [
    /*{
      "icon": lockOutlineIcon,
      "name": "Change Password",
    },*/
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

  @override
  void onReady() async {
    await getTermsAndConditions();
    super.onReady();
  }

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
        "image": File(image), //file type
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
    int id =
        await SharedPreferencesServices.getIntData(key: "user_id_int") ?? 0;

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
    await SharedPreferencesServices.setBoolData(
      key: "isLoggedIn",
      value: false,
    );
    Get.deleteAll();
    Get.offAll(() => const LoginScreen());
  }

  requestDeletion() async {
    String email = Uri.encodeComponent("bikerrapp.in@gmail.com ");
    String subject = Uri.encodeComponent("Account Deletion Request");
    String body = Uri.encodeComponent('''
I hope this message finds you well. I am writing to request the deletion of my account on your platform.

Please find below the details associated with my account:

Username: [Your Username]
User ID: [Your User ID]
Phone Number: [Your Phone Number]
Email Address: [Your Email Address]
I would appreciate it if you could proceed with the deletion process as soon as possible. If there are any specific steps required from my end to complete this request, please let me know.

I understand that this action is irreversible and will result in the permanent removal of my account and all associated data after a period of 90 days and will be activated again if I log in to my account in this period of 90 days. I have ensured that I have backed up any necessary information before making this request.

Thank you for your prompt attention to this matter. Kindly confirm the deletion of my account via email at your earliest convenience.

Sincerely,
[Your Name]
''');
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail, mode: LaunchMode.externalApplication)) {
      log("requestDeletion worked", name: "skjdflksjdflksfd");
    } else {
      log("requestDeletion didn't worked", name: "skjdflksjdflksfd");
    }
    log("requestDeletion called");
  }

  getTermsAndConditions() async {
    var res = await HttpService.get("cms-page", isLoading: isConditionsLoading);
    log("$res");
    termsAndConditions.value = res["data"];
    termsAndConditions.refresh();
    log("$termsAndConditions", name: "sdjksdg");
  }

  termsAndPolicies(index) async {
    log("${termsAndConditions[index]["title"]}", name: "sdfsdgfsgg");
    switch (index) {
      case 0:
        Get.to(() => TermsAndPoliciesScreen(
              title: termsAndConditions[index]["title"],
              body: termsAndConditions[index]["description"],
            ));
        break;
      case 1:
        Get.to(() => TermsAndPoliciesScreen(
              title: termsAndConditions[index]["title"],
              body: termsAndConditions[index]["description"],
            ));
        break;
      case 2:
        Get.to(() => TermsAndPoliciesScreen(
              title: termsAndConditions[index]["title"],
              body: termsAndConditions[index]["description"],
            ));
        break;
      default:
    }
  }

  changePassword() async {
    var cp = await SharedPreferencesServices.getStringData(key: "password");
    if (cp != currentPassCntrl.value.value.text.trim())
      return getToast("Current password is Wrong!");
    if (cp == newPassCntrl.value.value.text.trim())
      return getToast("New password cannot be same as current password");
    if (newPassCntrl.value.value.text.trim() !=
        conPassCntrl.value.value.text.trim())
      return getToast("Password didn't match!");
    else {
      var res = await HttpService.post(
        "change-password",
        bodyTag: {
          "current_password": currentPassCntrl.value.value.text.trim(),
          "new_password": newPassCntrl.value.value.text.trim(),
          "new_confirm_password": conPassCntrl.value.value.text.trim(),
        },
        headerData: {'Authorization': 'Bearer ${Traccar.apiToken.value}'},
        isLoading: isChangePassword,
      );
      log("$res");
    }
  }
}
