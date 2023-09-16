import 'package:another_flushbar/flushbar.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

getToast(String? message) {
  return Get.context == null
      ? null
      : Flushbar(
          margin: EdgeInsets.only(bottom: 5.r),
          messageText: Text(
            message!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackColor,
              fontSize: 18.sp,
            ),
          ),
          duration: const Duration(milliseconds: 2500),
          backgroundColor: redColor,
          isDismissible: false,
          flushbarPosition: FlushbarPosition.BOTTOM,
          flushbarStyle: FlushbarStyle.FLOATING,
        ).show(Get.context!);
}
