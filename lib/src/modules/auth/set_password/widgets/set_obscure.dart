import 'package:bikerr_partner_app/src/modules/auth/set_password/controllers/set_pass_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordObscureComp extends StatelessWidget {
  final SetPasswordController sc;
  const PasswordObscureComp({required this.sc, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(() {
          return Checkbox(
              side: BorderSide(color: dGreyColor),
              activeColor: redColor,
              checkColor: dGreyColor,
              value: sc.isObscure.value,
              onChanged: (e) {
                sc.isObscure.value = !sc.isObscure.value;
              });
        }),
        const ThinTextComp(data: "Show Password"),
      ],
    );
  }
}
