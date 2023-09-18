import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/booked_bikes_listing.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/options_listing_comp.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/title_and_btn.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/user_details_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bmc = Get.find<BaseController>();
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetailsComp(bmc: bmc),
            30.height,
            OptionListingComp(bmc: bmc),
            10.height,
            TitleAndButtonComp(bmc: bmc),
            10.height,
            BookedBikesListingComp(
              bmc: bmc,
              listLength: 3,
              list: bmc.hc.bookedAndTakenBikeData,
            ),
          ],
        ),
      ),
    );
  }
}
