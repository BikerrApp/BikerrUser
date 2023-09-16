import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditButtonComp extends StatelessWidget {
  final void Function()? onTap;
  const EditButtonComp({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        padding: EdgeInsets.all(5.r),
        child: Icon(
          Icons.mode_edit_rounded,
          color: redColor,
        ),
      ),
    );
  }
}
