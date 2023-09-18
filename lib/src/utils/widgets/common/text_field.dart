import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextfieldComp extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String hintText;
  final String suffixIcon;
  final bool obscureText;
  final bool isExpanded;
  const CustomTextfieldComp({
    required this.title,
    required this.controller,
    required this.textInputAction,
    required this.keyboardType,
    required this.hintText,
    this.suffixIcon = "",
    this.obscureText = false,
    this.isExpanded = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThinTextComp(data: title),
        5.height,
        TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: whiteColor,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
              filled: true,
              fillColor: blackColor,
              hintText: hintText,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w300,
                color: whiteColor,
                fontSize: 12.sp,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: lGreyColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: lGreyColor),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.all(12.r),
                child: suffixIcon.isNotEmpty
                    ? SvgPicture.asset(suffixIcon)
                    : null,
              )),
        ),
      ],
    );
  }
}
