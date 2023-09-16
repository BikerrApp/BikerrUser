import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/my_listing_list.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';

class MyListingScreen extends StatelessWidget {
  final BaseController bmc;
  const MyListingScreen({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "My Listing"),
      body: MyListingListComp(bmc: bmc),
    );
  }
}
