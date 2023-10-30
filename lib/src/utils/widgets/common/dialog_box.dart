import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

dialogBox({
  required String title,
  required Widget centerChild,
  bool dismissible = true,
}) {
  return showDialog(
    context: Get.context!,
    barrierDismissible: dismissible,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.zero,
        backgroundColor: dGreyColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title.isEmpty
                ? const SizedBox()
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    child: MediumTextComp(data: title),
                  ),
            title.isEmpty
                ? const SizedBox()
                : Divider(
                    height: 0.h,
                    thickness: 2,
                    color: lGreyColor,
                  ),
            Padding(
              padding: EdgeInsets.all(20.r),
              child: SizedBox(
                child: Material(
                  color: Colors.transparent,
                  child: centerChild,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
