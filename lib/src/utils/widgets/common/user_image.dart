import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';

class UserImageComp extends StatelessWidget {
  final double radius;
  final ImageProvider<Object> backgroundImage;
  const UserImageComp({
    required this.radius,
    required this.backgroundImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: redColor,
      radius: radius,
      backgroundImage: backgroundImage,
    );
  }
}
