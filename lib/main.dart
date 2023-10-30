// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bikerr_partner_app/src/modules/splash/splash_screen.dart';
import 'package:bikerr_partner_app/src/services/shared_preferences.dart';
import 'package:bikerr_partner_app/src/services/sql_db_services.dart';
import 'package:bikerr_partner_app/src/services/traccar_services.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  await SqlDBService.sqlDBServiceinstance.database;
  bool isLogin =
      (await SharedPreferencesServices.getBoolData(key: "isLoggedIn")) ?? false;
  await Traccar.getHeader();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) async => runApp(
      MainApp(isLogin: isLogin),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool isLogin;
  const MainApp({required this.isLogin, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(isLogin: isLogin),
            theme: ThemeData(
              fontFamily: 'Poppins',
              scaffoldBackgroundColor: blackColor,
            ),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) => true;
  }
}
