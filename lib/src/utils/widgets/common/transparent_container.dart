import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransparentContainerComp extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const TransparentContainerComp({
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
          color: transblackColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(10.r),
        child: child,
      ),
    );
  }
}
