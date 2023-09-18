import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/booked_bike_details.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/booking_user_details.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/recieve_give_btn.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsComp extends StatelessWidget {
  final BaseController bmc;
  const BookingDetailsComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Order Details"),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            const BookedBikeDetails(),
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediumTextComp(
                      data: "To",
                      size: 14,
                      color: whiteColor,
                    ),
                    MediumTextComp(
                      data: "12.12.2022",
                      size: 16,
                      color: whiteColor,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediumTextComp(
                      data: "From",
                      size: 14,
                      color: whiteColor,
                    ),
                    MediumTextComp(
                      data: "12.12.2022",
                      size: 16,
                      color: whiteColor,
                    ),
                  ],
                ),
              ],
            ),
            20.height,
             BookingUserDetailsComp(bmc:bmc),
            const Spacer(),
            const RecieveGiveBtnComp(isRecieve: false),
          ],
        ),
      ),
    );
  }
}
