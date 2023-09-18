import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';

class CustomRadioBtnComp extends StatelessWidget {
  final dynamic value;
  final dynamic groupValue;
  final void Function(dynamic)? onChanged;
  final String name;
  const CustomRadioBtnComp({
    required this.groupValue,
    required this.name,
    required this.onChanged,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: whiteColor,
          fillColor: MaterialStateColor.resolveWith((states) => whiteColor),
        ),
        MediumTextComp(
          data: name,
          color: whiteColor,
          size: 14,
        )
      ],
    );
  }
}
