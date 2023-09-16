import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';

class AddBikeScreen extends StatelessWidget {
  final BaseController bmc;
  const AddBikeScreen({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Add Bike"),
      body: Column(children: []),
    );
  }
}
