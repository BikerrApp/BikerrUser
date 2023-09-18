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

  final isInsurance = "yes".obs;
  final isPollution = "yes".obs;

  final bikeImagesList = [].obs;

  addBikeImages() async {
    final ImagePicker ip = ImagePicker();
    final List<XFile> result = await ip.pickMultiImage(
      requestFullMetadata: false,
    );
    for (var i = 0; i < result.length; i++) {
      bikeImagesList.add(result[i].path);
    }
  }
}
