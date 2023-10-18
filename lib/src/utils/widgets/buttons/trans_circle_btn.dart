import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransCircleBtnComp extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const TransCircleBtnComp({
    required this.child,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: dGreyColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(50.r),
        ),
        padding: EdgeInsets.all(10.r),
        height: 65,
        width: 65,
        child: Center(child: child),
      ),
    );
  }
}
