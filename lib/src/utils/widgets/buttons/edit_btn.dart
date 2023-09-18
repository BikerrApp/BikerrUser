import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditButtonComp extends StatelessWidget {
  final void Function()? onTap;
  final bool isInvert;
  final bool isCircle;
  const EditButtonComp({
    required this.onTap,
    this.isInvert = false,
    this.isCircle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isInvert ? redColor : blackColor,
          borderRadius: isCircle
              ? BorderRadius.circular(50.r)
              : BorderRadius.circular(5.r),
        ),
        padding: isCircle ? EdgeInsets.all(10.r) : EdgeInsets.all(5.r),
        child: Icon(
          Icons.mode_edit_rounded,
          color: isInvert ? whiteColor : redColor,
        ),
      ),
    );
  }
}
