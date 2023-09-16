import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoldTextComp extends StatelessWidget {
  final String data;
  final double size;
  final Color? color;
  final bool isDecorate;
  const BoldTextComp({
    required this.data,
    this.size = 20,
    this.color,
    this.isDecorate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color ?? whiteColor,
        fontSize: size.sp,
        decoration: isDecorate ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
