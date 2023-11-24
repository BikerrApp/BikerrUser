import 'dart:convert';
import 'dart:developer';
import 'package:bikerr_partner_app/src/models/device_model.dart';
import 'package:bikerr_partner_app/src/models/geofence_model.dart';

import 'package:bikerr_partner_app/src/models/position_model.dart';
import 'package:bikerr_partner_app/src/models/stop_model.dart';
import 'package:bikerr_partner_app/src/models/summary_model.dart';
import 'package:bikerr_partner_app/src/services/http_client_service.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/utils/strings/url.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Traccar {
  static final headers = Rx<Map<String, String>>({});
  static final apiToken = Rxn<String>();

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

  static Future<http.Response> logout() async {
    headers.value['content-type'] = "application/x-www-form-urlencoded";

    final response = await http.delete(
      Uri.parse("${serverUrl}session"),
      headers: headers.value,
    );
    return response;
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

  static Future<http.Response> deleteDevice({
    required RxBool loading,
    required String id,
  }) async {
    headers.value['content-type'] = "application/json; charset=utf-8";
    headers.value['accept'] = "application/json";
    final response = await http.delete(
      Uri.parse("${serverUrl}devices/$id"),
      headers: headers.value,
    );
    return response;
  }

  static Future<List<Device>?> getDevices({required RxBool loading}) async {
    headers.value['content-type'] = "application/json; charset=utf-8";
    final response = await HttpService.getServer(
      "devices",
      isLoading: loading,
      headerData: headers.value,
    );
    log("$response");
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

  static Future<List<PositionModel>?> getPositions({
    required RxBool loading,
    required String deviceId,
    required String from,
    required String to,
  }) async {
    headers.value['Accept'] = "application/json";
    headers.value['content-type'] = "application/json; charset=utf-8";
    log("${serverUrl}positions?deviceId=$deviceId&from=$from&to=$to",
        name: "kdjsfhksjfd");
    log("http://bikerr.in:8082/api/positions?deviceId=8&from=2023-10-29T18:30:00.000Z&to=2023-10-30T18:30:00.000Z",
        name: "kdjsfhksjfd");
    final response = await HttpService.getServer(
      "positions?deviceId=$deviceId&from=$from&to=$to",
      isLoading: loading,
      headerData: headers.value,
    );
    log("$response", name: "kdjfkjdkfj");
    Iterable list = json.decode(response);
    return list.map((model) => PositionModel.fromJson(model)).toList();
  }

  static Future<List<Stop>?> getStops({
    required RxBool loading,
    required String deviceId,
    required String from,
    required String to,
  }) async {
    headers.value['Accept'] = "application/json";

    final response = await HttpService.getServer(
      "reports/stops?deviceId=$deviceId&from=$from&to=$to",
      isLoading: loading,
      headerData: headers.value,
    );
    log("$response", name: "kdjfkjdkfj");
    Iterable list = json.decode(response);
    return list.map((model) => Stop.fromJson(model)).toList();
  }

  static Future<List<Summary>?> getSummery({
    required RxBool loading,
    required String deviceId,
    required String from,
    required String to,
  }) async {
    headers.value['Accept'] = "application/json";

    final response = await HttpService.getServer(
      "reports/summary?deviceId=$deviceId&from=$from&to=$to&daily=false",
      isLoading: loading,
      headerData: headers.value,
    );
    log("$response", name: "Summary");
    Iterable list = json.decode(response);
    return list.map((model) => Summary.fromJson(model)).toList();
  }

  static Future<List> getNotificationTypes({required RxBool loading}) async {
    headers.value['content-type'] = "application/json";

    final response = await HttpService.getServer(
      "notifications/types",
      isLoading: loading,
      headerData: headers.value,
    );

    Iterable list = json.decode(response);
    return list.toList();
  }

  static Future<List> getNotifications({required RxBool loading}) async {
    headers.value['content-type'] = "application/json";

    final response = await HttpService.getServer(
      "notifications",
      isLoading: loading,
      headerData: headers.value,
    );

    Iterable list = json.decode(response);
    return list.toList();
  }

  static Future<List> setNotifications({
    required RxBool loading,
    required dynamic body,
  }) async {
    headers.value['Content-type'] = "application/json";

    final response = await HttpService.postServer(
      "notifications",
      isLoading: loading,
      bodyTag: body,
      headerData: headers.value,
    );

    Iterable list = json.decode(response);
    return list.toList();
  }

  static Future removeNotifications({
    required RxBool loading,
    required int id,
  }) async {
    headers.value['content-type'] = "application/json";

    final response = await http.delete(
      Uri.parse("${serverUrl}notifications/$id"),
      headers: headers.value,
    );

    return response;
  }

  static Future<List<GeofenceModel>?> getGeoFencesByUserID({
    required RxBool loading,
    required String userId,
  }) async {
    headers.value['Accept'] = "application/json";

    final response = await HttpService.getServer(
      "geofences?userId=$userId",
      isLoading: loading,
      headerData: headers.value,
    );
    log("$response", name: "lkajsdlkdasjklfas");

    Iterable list = json.decode(response);
    log("$list", name: "lkajsdlkdasjklfas");
    return list.map((model) => GeofenceModel.fromJson(model)).toList();
  }

  static Future<List<GeofenceModel>?> getGeoFencesByDeviceID({
    required String deviceId,
    required RxBool loading,
  }) async {
    headers.value['Accept'] = "application/json";

    final response = await HttpService.getServer(
      "geofences?deviceId=$deviceId",
      isLoading: loading,
      headerData: headers.value,
    );

    Iterable list = json.decode(response);
    return list.map((model) => GeofenceModel.fromJson(model)).toList();
  }

  static Future<http.Response> addPermission({
    required String permission,
    required RxBool loading,
  }) async {
    headers.value['content-type'] = "application/json; charset=utf-8";

    final response = await HttpService.postServer(
      "permissions",
      isLoading: loading,
      bodyTag: permission,
      headerData: headers.value,
    );
    return response;
  }

  static Future<http.StreamedResponse> deletePermission(deviceId, fenceId,
      {required RxBool loading}) async {
    loading.value = true;
    http.Request rq =
        http.Request('DELETE', Uri.parse("${serverUrl}permissions"))..headers;
    rq.headers.addAll(<String, String>{
      "Accept": "application/json",
      "Content-type": "application/json; charset=utf-8",
      "cookie": headers.value['cookie'].toString()
    });
    rq.body = jsonEncode({"deviceId": deviceId, "geofenceId": fenceId});
    loading.value = false;
    return http.Client().send(rq);
  }

  static Future<http.Response> deleteGeofence(dynamic id,
      {required RxBool loading}) async {
    headers.value['content-type'] = "application/json; charset=utf-8";
    loading.value = true;
    final response = await http.delete(
      Uri.parse("${serverUrl}geofences/$id"),
      headers: headers.value,
    );
    loading.value = false;
    return response;
  }

  static Future<http.Response> addGeofence({
    required String fence,
    required RxBool loading,
  }) async {
    headers.value['content-type'] = "application/json; charset=utf-8";

    final response = await HttpService.postServer(
      Uri.parse("geofences"),
      bodyTag: fence,
      headerData: headers.value,
      isLoading: loading,
    );
    return response;
  }

  static Future<http.Response> sendCommands({
    required RxBool loading,
    required String command,
  }) async {
    headers.value['content-type'] = "application/json";

    final response = await HttpService.postServer(
      "commands/send",
      bodyTag: command,
      headerData: headers.value,
      isLoading: loading,
    );
    return response;
  }

  static Future<http.Response> updateUser(String user, String id) async {
    headers.value['content-type'] = "application/json; charset=utf-8";

    final response = await http.put(
      Uri.parse("${serverUrl}users/$id"),
      body: user,
      headers: headers.value,
    );
    log(response.body);
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
    var apiT = await SharedPreferencesServices.getStringData(key: "apiToken");
    log("$headerData", name: "svsavsvsv");
    if (headerData != null) {
      Map<String, dynamic> decodedData = jsonDecode(headerData);
      Map<String, String> h = Map<String, String>.from(decodedData);

      log("$h", name: "svsavsvsv");
      headers.value = h;
      apiToken.value = apiT;
    } else {
      log("no header data found");
    }
  }
}
