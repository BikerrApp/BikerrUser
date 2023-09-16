import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class BackButtonComp extends StatelessWidget {
  final void Function()? onTap;
  const BackButtonComp({this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ??
            () {
              Get.back();
            },
        child: Image.asset(
          backIcon,
          height: 30.h,
        ));
  }
}
