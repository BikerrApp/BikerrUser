import 'dart:convert';

import 'package:bikerr_partner_app/src/models/geo_permission_model.dart';
import 'package:bikerr_partner_app/src/models/geofence_model.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:get/get.dart';

class GeoFenceController extends GetxController {
  final isGeoFenceLoading = false.obs;
  final isGetFenceLoading = false.obs;
  final isUpdateFenceLoading = false.obs;
  final isRemoveFenceLoading = false.obs;
  final isDeleteFenceLoading = false.obs;
  final fenceList = <GeofenceModel>[].obs;
  final selectedFenceList = <int>[].obs;
  late final bmc = Get.find<BaseController>();

  @override
  void onInit() {
    getFences();
    super.onInit();
  }

  void getFences() async {
    var userId = await SharedPreferencesServices.getIntData(key: "userId");

    Traccar.getGeoFencesByUserID(
      userId: userId.toString(),
      loading: isGeoFenceLoading,
    ).then((value) {
      if (value!.isNotEmpty) {
        fenceList.addAll(value);
        fenceList.refresh();
        getSelectedFenceList();
      } else {}
    });
  }

  void getSelectedFenceList() {
    Traccar.getGeoFencesByDeviceID(
      deviceId: "${bmc.mapC.dc.selectedDeviceId.value}",
      loading: isGetFenceLoading,
    ).then((value) {
      if (value!.isNotEmpty) {
        for (var e in value) {
          selectedFenceList.add(e.id!);
          selectedFenceList.refresh();
        }
      } else {}
    });
  }

  void updateFence(id) {
    fenceList.clear();
    selectedFenceList.clear();
    GeofencePermModel permissionModel = GeofencePermModel();
    permissionModel.deviceId = bmc.mapC.dc.selectedDeviceId.value;
    permissionModel.geofenceId = id;

    var perm = json.encode(permissionModel);
    Traccar.addPermission(
      permission: perm.toString(),
      loading: isUpdateFenceLoading,
    ).then((value) {
      if (value.statusCode == 204) {
        fenceList.clear();
        selectedFenceList.clear();
        fenceList.refresh();
        selectedFenceList.refresh();
        getFences();
      } else {}
    });
  }

  void removeFence(id) {
    Traccar.deletePermission(
      bmc.mapC.dc.selectedDeviceId.value,
      id,
      loading: isRemoveFenceLoading,
    ).then((value) {
      if (value.statusCode == 204) {
        fenceList.clear();
        selectedFenceList.clear();
        fenceList.refresh();
        selectedFenceList.refresh();
        getFences();
      } else {}
    });
  }

  void deleteFence(id) {
    Traccar.deleteGeofence(
      id,
      loading: isDeleteFenceLoading,
    ).then((value) {
      if (value.statusCode == 204) {
        fenceList.clear();
        selectedFenceList.clear();
        fenceList.refresh();
        selectedFenceList.refresh();
        getFences();
      } else {}
    });
  }
}
