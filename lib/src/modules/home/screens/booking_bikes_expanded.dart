import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/booked_bikes_listing.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookedBikesExpandedComp extends StatelessWidget {
  final BaseController bmc;
  const BookedBikesExpandedComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Upcoming Bookings"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: BookedBikesListingComp(
            bmc: bmc,
            listLength: 13,
            list: const [],
          ),
        ),
      ),
    );
  }
}
