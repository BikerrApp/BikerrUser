import 'dart:developer';

import 'package:bikerr_partner_app/src/utils/strings/url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  static Future<Map<String, dynamic>> get(
    url, {
    headerData,
    required RxBool isLoading,
  }) async {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('$commonBaseUrl$url'),
      headers: headerData,
    );

    final jsonResponse = json.decode(response.body);
    log("$jsonResponse", name: "response get");
    isLoading.value = false;
    return jsonResponse;
  }

  static Future getServer(
    url, {
    headerData,
    required RxBool isLoading,
  }) async {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('$serverUrl$url'),
      headers: headerData ??
          {
            'content-type': 'application/json; charset=utf-8',
          },
    );

    log(response.body, name: "response get");
    isLoading.value = false;
    return response.body;
  }

  static Future postServer(
    url, {
    bodyTag,
    headerData,
    required RxBool isLoading,
  }) async {
    isLoading.value = true;
    print('___ay $bodyTag');

    final response = await http.post(
      Uri.parse('$serverUrl$url'),
      headers: headerData,
      body: url == 'users' ? jsonEncode(bodyTag) : bodyTag,
    );
    print('___ay ${response.body}');

    isLoading.value = false;
    return response;
  }

  static Future<Map<String, dynamic>> post(
    url, {
    bodyTag,
    headerData,
    bool isServer = false,
    required RxBool isLoading,
  }) async {
    isLoading.value = true;

    final response = await http.post(
      isServer ? Uri.parse('$serverUrl$url') : Uri.parse('$commonBaseUrl$url'),
      headers: headerData ?? {'Content-Type': 'application/json'},
      body: isServer ? bodyTag : jsonEncode(bodyTag),
    );
    final jsonResponse = json.decode(response.body);

    isLoading.value = false;
    return jsonResponse;
  }
}
