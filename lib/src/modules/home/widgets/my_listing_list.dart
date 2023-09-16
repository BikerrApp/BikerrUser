import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/bike_image.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/edit_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyListingListComp extends StatelessWidget {
  final BaseController bmc;
  const MyListingListComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
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
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const MediumTextComp(
                          data: "Bike Name",
                          size: 16,
                        ),
                        const MediumTextComp(
                          data: "Bike Model",
                          size: 12,
                        ),
                        const MediumTextComp(
                          data: "Bike RC Number",
                          size: 14,
                        ),
                        const MediumTextComp(
                          data: "Bike Price Per Day",
                          size: 14,
                        ),
                        10.height,
                        Obx(() {
                          return Row(
                            children: [
                              SizedBox(
                                height: 25,
                                child: FittedBox(
                                  child: CupertinoSwitch(
                                    value: bmc.hc.switchValue.value,
                                    onChanged: (value) {
                                      bmc.hc.switchValue.value = value;
                                    },
                                    thumbColor: whiteColor,
                                    activeColor: greenColor,
                                    trackColor: redColor,
                                  ),
                                ),
                              ),
                              10.width,
                              MediumTextComp(
                                data: bmc.hc.switchValue.value
                                    ? "Active"
                                    : "Booked",
                                color: bmc.hc.switchValue.value
                                    ? greenColor
                                    : redColor,
                                size: 13,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                    const Spacer(),
                    EditButtonComp(onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
