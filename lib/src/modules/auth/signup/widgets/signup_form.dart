import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/auth/signup/controllers/signup_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';

class SignUpFormComp extends StatelessWidget {
  final SignUpController sc;
  const SignUpFormComp({required this.sc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfieldComp(
          title: "UserId",
          controller: sc.userIdCntrl.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          hintText: "Enter UserId",
          suffixIcon: userIcon,
        ),
        25.height,
        CustomTextfieldComp(
          title: "User Name",
          controller: sc.userNameCntrl.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          hintText: "Enter User Name",
          suffixIcon: userIcon,
        ),
        25.height,
        CustomTextfieldComp(
          title: "Email",
          controller: sc.emailCntrl.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          hintText: "Enter Email Id",
          suffixIcon: atIcon,
        ),
        25.height,
        CustomTextfieldComp(
          title: "Mobile Number",
          controller: sc.mobNumberCntrl.value,
          textInputAction: TextInputAction.done,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
          hintText: "Enter Mobile Number",
          suffixIcon: phoneIcon,
        ),
        // 25.height,
        // CustomTextfieldComp(
        //   title: "Password",
        //   controller: sc.passwordCntrl.value,
        //   textInputAction: TextInputAction.done,
        //   keyboardType: TextInputType.visiblePassword,
        //   hintText: "Set Password",
        //   suffixIcon: lockIcon,
        // ),
      ],
    );
  }
}
