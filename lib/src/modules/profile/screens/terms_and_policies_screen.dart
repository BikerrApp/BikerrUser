import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndPoliciesScreen extends StatelessWidget {
  final String title;
  final String body;
  const TermsAndPoliciesScreen({
    required this.title,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: title),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: SingleChildScrollView(
          child: Html(
            data: body,
            style: {"body": Style(color: whiteColor)},
          ),
        ),
      ),
    );
  }
}
