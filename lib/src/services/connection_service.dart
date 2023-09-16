import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetStatusController extends GetxController {
  final connectionStatus = ConnectivityResult.none.obs;
  final Connectivity connectivity = Connectivity();
  final isInternetConnected = true.obs;
  final isDataConnected = true.obs;

  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void onInit() async {
    super.onInit();
    await isConnectivityOn();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateStatus);
  }

  Future<void> isConnectivityOn() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }
    return updateStatus(result);
  }

  void updateStatus(ConnectivityResult? result) async {
    connectionStatus.value = result!;
    switch (result) {
      case ConnectivityResult.wifi:
        {
          log("$result", name: "internet connectivity");
          await isUserDataConnected();
          isInternetConnected.value = true;
        }
        break;
      case ConnectivityResult.mobile:
        {
          log("$result", name: "internet connectivity");
          await isUserDataConnected();
          isInternetConnected.value = true;
        }
        break;
      case ConnectivityResult.vpn:
        {
          log("$result", name: "internet connectivity");
          await isUserDataConnected();
          isInternetConnected.value = true;
        }
        break;
      default:
        {
          isInternetConnected.value = false;
          isDataConnected.value = false;
          // getToast("Internet Not Connected", bgColor: errorColor);
        }
    }
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    isInternetConnected.value = false;
    isDataConnected.value = false;
    super.onClose();
  }

  Future<bool> isUserDataConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      var res = result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      isDataConnected.value = res;
      log("$res", name: "userrrr");
      return res;
    } on SocketException catch (_) {
      isDataConnected.value = false;
      return false;
    }
  }
}
