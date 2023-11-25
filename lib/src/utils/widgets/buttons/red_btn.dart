import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RedButtonComp extends StatelessWidget {
  final String btnName;
  final void Function()? onTap;
  final RxBool isLoading;
  final double? width;
  final bool isSmall;
  final bool isChange;
  const RedButtonComp({
    required this.btnName,
    required this.onTap,
    required this.isLoading,
    this.width,
    this.isSmall = false,
    this.isChange = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: isChange ? greenColor : redColor),
          color: isChange
              ? greenColor.withOpacity(.25)
              : redColor.withOpacity(.25),
          borderRadius: BorderRadius.circular(50.r),
        ),
        height: 45.h,
        width: width,
        child: Obx(
          () {
            return Center(
              child: isLoading.value
                  ? CircularProgressIndicator(color: whiteColor)
                  : MediumTextComp(
                      data: btnName, size: isSmall ? 12.sp : 18.sp),
            );
          },
        ),
      ),
    );
  }
}
