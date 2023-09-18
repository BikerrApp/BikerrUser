import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/screens/booking_details.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/bike_image.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BikeDetailsComp extends StatelessWidget {
  final BaseController bmc;
  const BikeDetailsComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          Get.to(() =>  BookingDetailsComp(bmc:bmc));
        },
        child: Container(
          decoration: BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(10.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BikeImageComp(),
              15.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      40.width,
                      MediumTextComp(
                        data: "Booked",
                        size: 10,
                        color: redColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MediumTextComp(
                            data: "To",
                            size: 10,
                            color: whiteColor,
                          ),
                          MediumTextComp(
                            data: "12.12.2022",
                            size: 12,
                            color: whiteColor,
                          ),
                        ],
                      ),
                      69.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MediumTextComp(
                            data: "From",
                            size: 10,
                            color: whiteColor,
                          ),
                          MediumTextComp(
                            data: "12.12.2022",
                            size: 12,
                            color: whiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  5.height,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: blackColor,
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
        ),
      ),
    );
  }
}
