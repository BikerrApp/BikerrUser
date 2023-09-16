import 'package:bikerr_partner_app/src/utils/strings/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BikeImageComp extends StatelessWidget {
  const BikeImageComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      height: 120,
      width: 120,
      child: Image.asset(bikeImage),
    );
  }
}
