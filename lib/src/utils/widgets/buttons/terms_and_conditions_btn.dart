import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/bold_text_comp.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsBtn extends StatelessWidget {
  const TermsAndConditionsBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BoldTextComp(
      data: "Terms and Conditions",
      color: redColor,
      isDecorate: true,
      size: 12,
    );
  }
}
