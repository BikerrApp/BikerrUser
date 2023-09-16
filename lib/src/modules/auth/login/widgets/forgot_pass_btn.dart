import 'package:bikerr_partner_app/src/modules/auth/forgot_password/forgot_pass.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassBtn extends StatelessWidget {
  const ForgotPassBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ForgotPasswordScreen());
      },
      child: const Align(
        alignment: Alignment.centerRight,
        child: ThinTextComp(data: "Forgot Password ?"),
      ),
    );
  }
}
