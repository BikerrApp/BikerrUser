import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/base/widgets/base_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/bottom_nav_bar.dart';

class BaseClass extends StatelessWidget {
  const BaseClass({super.key});

  @override
  Widget build(BuildContext context) {
    final bmc = Get.put(BaseController());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BasePageViewComp(bmc: bmc),
        bottomNavigationBar: BaseBottomNavComp(bmc: bmc),
      ),
    );
  }
}
