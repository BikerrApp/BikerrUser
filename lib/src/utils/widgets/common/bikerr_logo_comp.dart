import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BikerrLogoComp extends StatelessWidget {
  const BikerrLogoComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      bikerrLogo,
      height: 70.h,
    );
  }
}
