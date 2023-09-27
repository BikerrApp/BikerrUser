import 'dart:io';

import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddBikeImagesComp extends StatelessWidget {
  final BaseController bmc;
  const AddBikeImagesComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediumTextComp(
            data: "Bike Images",
            color: whiteColor,
            size: 15,
          ),
          10.height,
          Obx(() {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...List.generate(
                    bmc.ac.bikeImagesList.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: redColor),
                          borderRadius: BorderRadius.circular(10.r),
                          color: greyColor,
                          image: DecorationImage(
                            image: Image.file(
                              File(bmc.ac.bikeImagesList[index]),
                            ).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 120.h,
                        width: 140.w,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await bmc.ac.addBikeImages();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: redColor),
                        borderRadius: BorderRadius.circular(10.r),
                        color: greyColor,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Column(
                        children: [
                          SvgPicture.asset(uploadOutlineIcon),
                          MediumTextComp(
                            data: "Uplaod your\n Bike Images\n here",
                            color: whiteColor.withOpacity(0.2),
                            isCenter: true,
                            size: 13,
                          ),
                          MediumTextComp(
                            data: "Browse",
                            color: redColor,
                            isDecorate: true,
                            size: 13,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          15.height,
          CustomTextfieldComp(
            title: "Per Day Rent Rs *",
            controller: bmc.ac.rentCntrl.value,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            hintText: "Enter Rs",
          ),
          50.height,
          RedButtonComp(
            btnName: "Next",
            onTap: () {
              bmc.ac.validateBasicBikeInfo();
            },
            isLoading: bmc.ac.isDocumentLoading,
          )
        ],
      ),
    );
  }
}
