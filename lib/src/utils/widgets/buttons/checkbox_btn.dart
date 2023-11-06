import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:flutter/material.dart';

class CheckBoxBtnComp extends StatelessWidget {
  final dynamic value;
  final void Function(dynamic)? onChanged;
  const CheckBoxBtnComp({
    required this.onChanged,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: whiteColor,
      tristate: true,
      fillColor: MaterialStateColor.resolveWith((states) => whiteColor),
      side: BorderSide(color: dGreyColor),
    );
  }
}
