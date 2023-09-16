import 'package:bikerr_partner_app/src/modules/auth/signup/signup_screen.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/bold_text_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpBtn extends StatelessWidget {
  final bool isLogin;
  const SignUpBtn({required this.isLogin, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThinTextComp(
          data: isLogin
              ? "Don't have an account ? "
              : "Already have an account ? ",
        ),
        GestureDetector(
          onTap: () {
            isLogin ? Get.to(() => const SignUpScreen()) : Get.back();
          },
          child: BoldTextComp(
            data: isLogin ? "Sign Up" : "Log In",
            color: redColor,
            size: 12,
          ),
        ),
      ],
    );
  }
}
