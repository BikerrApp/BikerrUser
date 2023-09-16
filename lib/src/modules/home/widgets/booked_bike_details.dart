import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/bike_image.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookedBikeDetails extends StatelessWidget {
  const BookedBikeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      height: 110.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BikeImageComp(),
          15.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediumTextComp(
                data: "Bike Name",
                size: 14,
                color: redColor,
              ),
              MediumTextComp(
                data: "Bike Details",
                size: 12,
                color: redColor,
              ),
              Row(
                children: [
                  const MediumTextComp(
                    data: "Order Id : 9090909",
                    size: 11,
                  ),
                  30.width,
                  MediumTextComp(
                    data: "Booked",
                    size: 12,
                    color: redColor,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: greyColor,
                ),
                padding: EdgeInsets.all(5.r),
                child: MediumTextComp(
                  data: "Payment Received: ₹ 1380",
                  size: 10,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
