import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThinTextComp extends StatelessWidget {
  final String data;
  final double size;
  final Color? color;
  final bool isCenter;
  const ThinTextComp({
    required this.data,
    this.size = 12,
    this.color,
    this.isCenter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        color: color ?? whiteColor,
        fontSize: size.sp,
      ),
    );
  }
}
