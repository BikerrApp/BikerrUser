import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';

class UserDetailsFormComp extends StatelessWidget {
  final BaseController bmc;
  const UserDetailsFormComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfieldComp(
          title: "UserId",
          controller: bmc.pc.userIdCntrl.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          hintText: "Enter UserId",
          suffixIcon: userIcon,
        ),
        25.height,
        CustomTextfieldComp(
          title: "User Name",
          controller: bmc.pc.userNameCntrl.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          hintText: "Enter User Name",
          suffixIcon: userIcon,
        ),
        25.height,
        CustomTextfieldComp(
          title: "Email",
          controller: bmc.pc.emailCntrl.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          hintText: "Enter Email Id",
          suffixIcon: atIcon,
        ),
        25.height,
        CustomTextfieldComp(
          title: "Mobile Number",
          controller: bmc.pc.mobNumberCntrl.value,
          textInputAction: TextInputAction.done,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
          hintText: "Enter Mobile Number",
          suffixIcon: phoneIcon,
        ),
      ],
    );
  }
}
