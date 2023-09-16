import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreyButton extends StatelessWidget {
  final String btnName;
  final void Function()? onTap;
  const GreyButton({required this.btnName, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: dGreyColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: redColor),
        ),
        height: 45.h,
        child: Center(
          child: MediumTextComp(data: btnName, size: 18),
        ),
      ),
    );
  }
}
