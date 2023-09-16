import 'dart:convert';
import 'dart:developer';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/socket_handling/socket_response_handler.dart';
import 'package:bikerr_partner_app/src/services/connection_service.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/url.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class SocketController extends GetxController {
  IOWebSocketChannel? socket;
  final isConnected = false.obs;
  final internetController = Get.put(InternetStatusController());
  final srh = Get.put(SocketResponseHandlerController());
  late final bmc = Get.find<BaseController>();

  @override
  void onInit() async {
    await connectSocket();
    super.onInit();
  }

  @override
  void onClose() {
    log("socket closed", name: "socketIsClosed");
    socket!.sink.close();
    super.onClose();
  }

  connectSocket() async {
    // {cookie: JSESSIONID=node06633ng28afuh16uy7bdzdi06y201.node0}
    log("${Traccar.headers.value}", name: "dhsfhasjdfhks");
    socket = IOWebSocketChannel.connect(
      socketBaseUrl,
      headers: Traccar.headers.value,
    );
    log("socket is connected", name: "socket is connected");
    isConnected.value = true;
    await onResponse();
  }

  reConnectSocket() async {
    if (socket == null) {
      await connectSocket();
    } else {}
  }

  onResponse() {
    socket!.stream.listen((event) async {
      log("$event", name: "sjdhfhaskfhalskhfliashf");
      var data = json.decode(event);
      if (data["events"] != null) {
        log("${srh.eventsData.value}", name: "qwewrqtrt");
      } else if (data["positions"] != null) {
        log("${data["positions"]}", name: "satqwrasga");
        srh.addPositionsFromSocket(positionData: data["positions"]);
      } else if (data["devices"] != null) {
        log("${srh.devicesData.value}", name: "qwewrqtrt");
      }
    });
  }
}
