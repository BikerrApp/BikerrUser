import 'dart:io';

import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/edit_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImageComp extends StatelessWidget {
  final double radius;
  final String imagePath;
  final bool isEdit;
  final void Function()? onEditTap;
  const UserImageComp({
    required this.radius,
    required this.imagePath,
    this.isEdit = false,
    this.onEditTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        CircleAvatar(
          backgroundColor: redColor,
          radius: radius.r,
          backgroundImage: imagePath.isNotEmpty
              ? Image.file(
                  File(imagePath),
                  fit: BoxFit.contain,
                ).image
              : Image.asset(
                  "assets/icons/1024.png",
                  fit: BoxFit.contain,
                ).image,
        ),
        isEdit
            ? EditButtonComp(
                onTap: onEditTap,
                isCircle: true,
                isInvert: true,
              )
            : const SizedBox(),
      ],
    );
  }
}
