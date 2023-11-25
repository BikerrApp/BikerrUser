import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/auth/login/controllers/login_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/bold_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionScreen extends StatelessWidget {
  final LoginController lc;
  const TermsAndConditionScreen({
    required this.lc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Terms and Conditions"),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: SingleChildScrollView(
            child: Column(
          children: [
            ...List.generate(
              lc.tncData.length,
              (index) => TermsPreviewComp(
                title: lc.tncData[index].title,
                body: lc.tncData[index].desc,
              ),
            )
          ],
        )),
      ),
    );
  }
}

class TermsPreviewComp extends StatelessWidget {
  final String title;
  final String body;
  const TermsPreviewComp({
    required this.title,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BoldTextComp(
          data: title,
          isDecorate: true,
        ),
        10.height,
        Html(
          data: body,
          style: {"body": Style(color: whiteColor)},
        ),
      ],
    );
  }
}
