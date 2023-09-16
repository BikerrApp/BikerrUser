import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/auth/forgot_password/controllers/forgot_pass_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordFormComp extends StatelessWidget {
  final ForgotPassController fc;
  const ForgotPasswordFormComp({required this.fc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfieldComp(
          title: "UserId",
          controller: fc.userIdCntrl.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          hintText: "Enter your User Id",
          suffixIcon: userIcon,
        ),
        25.height,
        CustomTextfieldComp(
          title: "Email",
          controller: fc.emailCntrl.value,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          hintText: "Enter Registered Email",
          suffixIcon: atIcon,
        ),
      ],
    );
  }
}
