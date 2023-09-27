// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';
import 'dart:io';

import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddBikeController extends GetxController {
  final isDocumentLoading = false.obs;
  final isDocumentInfo = false.obs;

  final bikeNameCntrl = TextEditingController().obs;
  final brandNameCntrl = TextEditingController().obs;
  final addDetailsCntrl = TextEditingController().obs;

  final pickUpAddressCntrl = TextEditingController().obs;
  final stateCntrl = TextEditingController().obs;
  final cityCntrl = TextEditingController().obs;
  final zipCodeCntrl = TextEditingController().obs;

  final rentCntrl = TextEditingController().obs;

  final registrationNoCntrl = TextEditingController().obs;
  final insuranceNoCntrl = TextEditingController().obs;
  final pollutionNoCntrl = TextEditingController().obs;

  final isInsurance = 1.obs;
  final isPollution = 1.obs;

  final bikeImagesList = [].obs;

  final registrationFrontSide = Rx<File>(File(""));
  final registrationBackSide = Rx<File>(File(""));

  final insuranceDocImage = Rx<File>(File(""));
  final pollutionDocImage = Rx<File>(File(""));

  addBikeImages() async {
    final ImagePicker ip = ImagePicker();
    final List<XFile> result = await ip.pickMultiImage(
      requestFullMetadata: false,
    );
    for (var i = 0; i < result.length; i++) {
      bikeImagesList.add(result[i].path);
      bikeImagesList.value = bikeImagesList.reversed.toList();
      bikeImagesList.refresh();
    }
  }

  uploadRegistrationFront() async {
    final ImagePicker ip = ImagePicker();
    final XFile? result = await ip.pickImage(source: ImageSource.gallery);
    registrationFrontSide.value = File(result!.path);
  }

  uploadRegistrationBack() async {
    final ImagePicker ip = ImagePicker();
    final XFile? result = await ip.pickImage(source: ImageSource.gallery);
    registrationBackSide.value = File(result!.path);
  }

  uploadInsuranceDoc() async {
    final ImagePicker ip = ImagePicker();
    final XFile? result = await ip.pickImage(source: ImageSource.gallery);
    insuranceDocImage.value = File(result!.path);
  }

  uploadPollutionDoc() async {
    final ImagePicker ip = ImagePicker();
    final XFile? result = await ip.pickImage(source: ImageSource.gallery);
    pollutionDocImage.value = File(result!.path);
  }

  validateBasicBikeInfo() {
    if (bikeNameCntrl.value.value.text.trim().isEmpty)
      return getToast("Please enter Bike name");
    if (brandNameCntrl.value.value.text.trim().isEmpty)
      return getToast("Please enter Bike Brand name");
    if (addDetailsCntrl.value.value.text.trim().isEmpty)
      return getToast("Please enter Bike Additional details");
    if (pickUpAddressCntrl.value.value.text.trim().isEmpty)
      return getToast("PickUp Address is Required");
    if (stateCntrl.value.value.text.trim().isEmpty)
      return getToast("Please enter a valid state name");
    if (cityCntrl.value.value.text.trim().isEmpty)
      return getToast("Please enter a valid city name");
    if (zipCodeCntrl.value.value.text.trim().isEmpty)
      return getToast("Zip code is required");
    if (bikeImagesList.isEmpty)
      return getToast("Please add atleast 1 Image of the Bike");
    if (rentCntrl.value.value.text.trim().isEmpty)
      return getToast("Bike rent is required");
    return isDocumentInfo.value = true;
  }

  validateDocumentInfo() async {
    if(registrationNoCntrl.value.value.text.trim().isEmpty) return getToast("Bike Registration is required");
    if(registrationFrontSide.value.path.isEmpty) return getToast("Bike Registration Front Side is required");
    if(registrationBackSide.value.path.isEmpty) return getToast("Bike Registration Back Side is required");
    return await addBikeToServer();
  }

  addBikeToServer() async {
    var response = await HttpService.post(
      "bike-store",
      headerData: {'Authorization': 'Bearer ${Traccar.apiToken.value}'},
      bodyTag: {
        "title": bikeNameCntrl.value.value.text.trim(),
        "brand": brandNameCntrl.value.value.text.trim(),
        "additional_info": addDetailsCntrl.value.value.text.trim(),
        "pickup_address": pickUpAddressCntrl.value.value.text.trim(),
        "state": stateCntrl.value.value.text.trim(),
        "city": cityCntrl.value.value.text.trim(),
        "zip_code": zipCodeCntrl.value.value.text.trim(),
        "image[]": bikeImagesList,
        "per_day_rent": rentCntrl.value.value.text.trim(),
        "registration_number": registrationNoCntrl.value.value.text.trim(),
        "rc_front_image": registrationFrontSide.value,
        "rc_back_image": registrationBackSide.value,
        "insurance": isInsurance.value,
        "insurance_number": insuranceNoCntrl.value,
        "insurance_image": insuranceDocImage.value,
        "pollution": isPollution.value,
        "pollution_number": pollutionNoCntrl.value.value.text.trim(),
        "pollution_image": pollutionDocImage.value,
      },
      isLoading: isDocumentLoading,
    );
    log("$response", name: "jdlashlfha");
  }
}
