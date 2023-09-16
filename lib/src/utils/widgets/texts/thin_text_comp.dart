import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThinTextComp extends StatelessWidget {
  final String data;
  final double size;
  final Color? color;
  const ThinTextComp(
      {required this.data, this.size = 12, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        color: color ?? whiteColor,
        fontSize: size.sp,
      ),
    );
  }
}
