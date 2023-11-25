import 'package:bikerr_partner_app/src/modules/auth/login/controllers/login_controller.dart';
import 'package:bikerr_partner_app/src/modules/auth/terms_and_conditions.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/bold_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionsBtn extends StatelessWidget {
  final LoginController lc;
  const TermsAndConditionsBtn({required this.lc, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          TermsAndConditionScreen(lc: lc),
          enableDrag: true,
          ignoreSafeArea: false,
          isDismissible: true,
          isScrollControlled: true,
        );
      },
      child: BoldTextComp(
        data: "Terms and Conditions",
        color: redColor,
        isDecorate: true,
        size: 12,
      ),
    );
  }
}

class TermsAndConditions {
  String title;
  String desc;

  TermsAndConditions({required this.title, required this.desc});
}
