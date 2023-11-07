import 'dart:convert';
import 'dart:developer';

import 'package:bikerr_partner_app/src/extensions/bitmap_convertor.dart';
import 'package:bikerr_partner_app/src/models/geo_permission_model.dart';
import 'package:bikerr_partner_app/src/models/geofence_model.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:get/get.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class GeoFenceController extends GetxController {
  final mapController = Rxn<MapmyIndiaMapController>();
  final isGeoFenceLoading = false.obs;
  final isGetFenceLoading = false.obs;
  final isUpdateFenceLoading = false.obs;
  final isRemoveFenceLoading = false.obs;
  final isDeleteFenceLoading = false.obs;
  final fenceList = <GeofenceModel>[].obs;
  final selectedFenceList = <int>[].obs;
  late final bmc = Get.find<BaseController>();
  final args = Get.arguments;
  final myLocSymbol = Rxn<Symbol>();

  @override
  void onInit() {
    getFences();
    super.onInit();
  }

  getFences() async {
    var userId = await SharedPreferencesServices.getIntData(key: "userId");

    await Traccar.getGeoFencesByUserID(
      userId: userId.toString(),
      loading: isGeoFenceLoading,
    ).then((value) {
      if (value!.isNotEmpty) {
        fenceList.clear();
        selectedFenceList.clear();
        fenceList.refresh();
        selectedFenceList.refresh();
        fenceList.addAll(value);
        fenceList.refresh();
        getSelectedFenceList();
      } else {}
    });
  }

  getSelectedFenceList() async {
    await Traccar.getGeoFencesByDeviceID(
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

  updateFence(id) async {
    fenceList.clear();
    selectedFenceList.clear();
    GeofencePermModel permissionModel = GeofencePermModel();
    permissionModel.deviceId = bmc.mapC.dc.selectedDeviceId.value;
    permissionModel.geofenceId = id;

    var perm = json.encode(permissionModel);
    await Traccar.addPermission(
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

  removeFence(id) async {
    await Traccar.deletePermission(
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

  deleteFence(id) {
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
        Get.back();
      } else {}
    });
  }

  createGeofence(i) {
    String fence = fenceList[i]
        .area!
        .replaceAll("CIRCLE (", "")
        .replaceAll(",", "")
        .replaceAll(")", "");

    List<String> fenceSplit = fence.split(" ");
    log("$i", name: "dsfksjdhfkjhd");
    addPolygon(
      double.parse(fenceSplit[0]),
      double.parse(fenceSplit[1]),
      double.parse(fenceSplit[2]),
    );
  }

  addPolygon(double lat, double lng, double rad) async {
    await addImageFromAsset("myLoc", myLocIcon, mapController.value!);
    myLocSymbol.value = await mapController.value!.addSymbol(
      SymbolOptions(
        geometry: LatLng(lat, lng),
        iconImage: "myLoc",
        iconSize: 0.2,
      ),
    );

    mapController.value!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 14),
      ),
    );

    mapController.value!.addCircle(CircleOptions(
      geometry: LatLng(lat, lng),
      circleRadius: rad / 10,
      circleColor: "#3bb2d0",
      circleOpacity: 0.4,
    ));
  }

  bool fenceCheckboxValue({required int fenceId}) {
    if (selectedFenceList.isNotEmpty && selectedFenceList.contains(fenceId)) {
      return true;
    } else {
      return false;
    }
  }

  fenceCheckboxChange(value, id) {
    if (value != null) {
      if (value) {
        updateFence(id);
      } else {
        removeFence(id);
      }
    }
  }
}
