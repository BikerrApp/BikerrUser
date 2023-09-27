import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerController extends GetxController {
  @override
  void onInit() async {
    await requestLocationPermission();
    await requestCameraPermission();
    super.onInit();
  }

  // Request camera permission
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  // Request location permission
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }
}
