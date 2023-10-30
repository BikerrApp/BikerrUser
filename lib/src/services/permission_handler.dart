import 'dart:developer';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerController extends GetxController {
  @override
  void onInit() async {
    log("App asked for permissions", name: "permission_handler");
    await requestLocationPermission();
    await requestCameraPermission();
    super.onInit();
  }

  // Request camera permission
  Future<bool> requestCameraPermission() async {
    if (await Permission.camera.isGranted) return true;
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  // Request location permission
  Future<bool> requestLocationPermission() async {
    if (await Permission.location.isGranted) return true;
    final status = await Permission.location.request();
    return status.isGranted;
  }
}
