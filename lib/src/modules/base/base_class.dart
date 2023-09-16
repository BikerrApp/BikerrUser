// ignore_for_file: depend_on_referenced_packages

// import 'dart:developer';

import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/base/widgets/base_page_view.dart';
// import 'package:bikerr_partner_app/src/redux/appstate.dart';
// import 'package:bikerr_partner_app/src/redux/view_model.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
import 'package:get/get.dart';
// import 'package:redux/redux.dart' show Store;
import 'widgets/bottom_nav_bar.dart';

class BaseClass extends StatelessWidget {
  const BaseClass({super.key});

  @override
  Widget build(BuildContext context) {
    final bmc = Get.put(BaseController());
    return /*StoreConnector<AppState, ViewModel>(
        onInit: (str) {
          str.state.devices!.clear();
          str.state.positions!.clear();
          str.state.events!.clear();
          bmc.mapC.dc.getAllDevices(str);
        },
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          bmc.vm.value = viewModel;
          bmc.vm.refresh();
          log("${bmc.vm.value}", name: "sdfkajsdkjhasklg");
          return */
        SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BasePageViewComp(bmc: bmc),
        bottomNavigationBar: BaseBottomNavComp(bmc: bmc),
      ),
    );
  }
}
