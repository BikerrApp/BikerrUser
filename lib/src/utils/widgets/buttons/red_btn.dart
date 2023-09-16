import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RedButtonComp extends StatelessWidget {
  final String btnName;
  final void Function()? onTap;
  final RxBool isLoading;
  const RedButtonComp({
    required this.btnName,
    required this.onTap,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: redColor),
          color: redColor.withOpacity(.25),
          borderRadius: BorderRadius.circular(50.r),
        ),
        height: 45.h,
        child: Obx(
          () {
            return Center(
              child: isLoading.value
                  ? CircularProgressIndicator(color: whiteColor)
                  : MediumTextComp(data: btnName, size: 18),
            );
          },
        ),
      ),
    );
  }
}
