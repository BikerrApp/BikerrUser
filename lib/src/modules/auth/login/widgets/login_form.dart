import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/auth/login/controllers/login_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';

class LoginFormComp extends StatelessWidget {
  final LoginController lc;
  const LoginFormComp({required this.lc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfieldComp(
          title: "UserId",
          controller: lc.userId.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          hintText: "Enter Your Name",
          suffixIcon: userIcon,
        ),
        25.height,
        CustomTextfieldComp(
          title: "Password",
          controller: lc.password.value,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.name,
          hintText: "Enter Your Password",
          suffixIcon: lockIcon,
        ),
      ],
    );
  }
}
