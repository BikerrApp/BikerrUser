import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/auth/login/controllers/login_controller.dart';
import 'package:bikerr_partner_app/src/modules/auth/login/widgets/forgot_pass_btn.dart';
import 'package:bikerr_partner_app/src/modules/auth/login/widgets/login_form.dart';
import 'package:bikerr_partner_app/src/modules/auth/login/widgets/sign_up_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/dark_grey_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/terms_and_conditions_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/bg_scaffold.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/bikerr_logo_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lc = Get.put(LoginController());
    return BackgroundScaffold(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.r),
          child: Column(
            children: [
              30.height,
              const BikerrLogoComp(),
              15.height,
              const MediumTextComp(data: "Login"),
              15.height,
              const ThinTextComp(
                  data: "Register with one of the following options"),
              50.height,
              LoginFormComp(lc: lc),
              60.height,
              DarkGreyButton(
                btnName: "Login",
                onTap: () {
                  lc.validateLogin();
                },
                isLoading: lc.isLogin,
              ),
              10.height,
              const ForgotPassBtn(),
              30.height,
              const SignUpBtn(isLogin: true),
              20.height,
              const TermsAndConditionsBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
