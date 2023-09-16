import 'dart:convert';
import 'dart:developer';
import 'package:bikerr_partner_app/src/models/device_model.dart';
import 'package:bikerr_partner_app/src/models/position_model.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Traccar {
  static final headers = Rx<Map<String, String>>({});

  static Future<http.Response?> login({
    required userId,
    required password,
    required RxBool loading,
  }) async {
    try {
      final response = await HttpService.postServer(
        "session",
        isLoading: loading,
        bodyTag: {"email": userId, "password": password},
        headerData: {"Content-Type": "application/x-www-form-urlencoded"},
      );
      log("${response.body}");

      await updateCookie(response);

      if (response.statusCode == 200) {
        await SharedPreferencesServices.setStringData(
            key: 'email', value: userId);
        await SharedPreferencesServices.setStringData(
            key: 'password', value: password);
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log("$e");
      return null;
    }
  }

  static Future<http.Response> addDevice({
    required RxBool loading,
    required String deviceData,
  }) async {
    headers.value['content-type'] = "application/json; charset=utf-8";
    final response = await HttpService.postServer(
      "devices",
      bodyTag: deviceData,
      isLoading: loading,
      headerData: headers.value,
    );
    return response;
  }

  static Future<List<Device>?> getDevices({required RxBool loading}) async {
    final response = await HttpService.getServer(
      "devices",
      isLoading: loading,
      headerData: headers.value,
    );
    Iterable list = json.decode(response.toString());
    return list.map((model) => Device.fromJson(model)).toList();
  }

  static Future<List<PositionModel>?> getLatestPositions(
      {required RxBool loading}) async {
    final response = await HttpService.getServer(
      "positions",
      isLoading: loading,
      headerData: headers.value,
    );

    Iterable list = json.decode(response);
    return list.map((model) => PositionModel.fromJson(model)).toList();
  }

  static Future<http.Response> sendCommands({
    required RxBool loading,
    required String command,
  }) async {
    headers.value['content-type'] = "application/json";

    final response = await HttpService.postServer(
      "commands/send",
      bodyTag: command,
      headerData: headers,
      isLoading: loading,
    );
    return response;
  }

  static updateCookie(http.Response response) async {
    String rawCookie = response.headers['set-cookie'].toString();

    if (rawCookie.isNotEmpty) {
      int index = rawCookie.indexOf(';');
      headers.value['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
      log("$headers", name: "dhsfhasjdfhks");
      await setHeader(headers.value);
    }
  }

  static setHeader(header) async {
    var headerString = jsonEncode(header);
    log(headerString, name: "dhsfhasjdfhks");
    await SharedPreferencesServices.setStringData(
        key: "headers", value: headerString);
    log("${await SharedPreferencesServices.getStringData(key: "headers")}",
        name: "dsagsdgasdfgasg");
  }

  static getHeader() async {
    var headerData =
        await SharedPreferencesServices.getStringData(key: "headers");
    log("$headerData", name: "svsavsvsv");
    if (headerData != null) {
      Map<String, dynamic> decodedData = jsonDecode(headerData);
      Map<String, String> h = Map<String, String>.from(decodedData);

      log("$h", name: "svsavsvsv");
      headers.value = h;
    } else {
      log("no header data found");
    }
  }
}
