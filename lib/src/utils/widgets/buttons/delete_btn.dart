import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteBtnComp extends StatelessWidget {
  final void Function()? onTap;
  const DeleteBtnComp({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.delete,
        color: redColor,
        size: 20.sp,
      ),
    );
  }
}