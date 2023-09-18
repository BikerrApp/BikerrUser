import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediumTextComp extends StatelessWidget {
  final String data;
  final double size;
  final Color? color;
  final bool isDecorate;
  final bool isCenter;
  const MediumTextComp({
    required this.data,
    this.size = 20,
    this.color,
    this.isDecorate = false,
    this.isCenter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: isCenter ? TextAlign.center: TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        color: color ?? whiteColor,
        fontSize: size.sp,
        decoration: isDecorate ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
