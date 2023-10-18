import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

PreferredSize commonAppBar({
  void Function()? onPressed,
  required String title,
  List<Widget>? actions,
}) {
  return PreferredSize(
    preferredSize: Size(double.infinity, 50.h),
    child: AppBar(
      backgroundColor: blackColor,
      leading: IconButton(
        onPressed: onPressed ??
            () {
              Get.back();
            },
        icon: Icon(
          Icons.arrow_back,
          color: whiteColor,
        ),
      ),
      title: MediumTextComp(
        data: title,
        size: 14,
        color: redColor,
      ),
      centerTitle: false,
      actions: actions,
    ),
  );
}
