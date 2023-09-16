import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/auth/set_password/controllers/set_pass_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordFormComp extends StatelessWidget {
  final SetPasswordController sc;
  const SetPasswordFormComp({required this.sc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          CustomTextfieldComp(
            title: "Password",
            controller: sc.passCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Set Password",
            suffixIcon: lockIcon,
            obscureText: sc.isObscure.value,
          ),
          25.height,
          CustomTextfieldComp(
            title: "Confirm Password",
            controller: sc.conPassCntrl.value,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Confirm Password",
            suffixIcon: lockIcon,
            obscureText: sc.isObscure.value,
          ),
        ],
      );
    });
  }
}
