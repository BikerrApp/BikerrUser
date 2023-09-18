import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerController extends GetxController {
  final permissionsList = [
    Permission.camera,
    Permission.location,
  ];

  askPermissions(){
    
  }
}
