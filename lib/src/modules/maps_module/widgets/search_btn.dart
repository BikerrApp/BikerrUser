import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/transparent_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchOnMapComp extends StatelessWidget {
  final BaseController bmc;
  const SearchOnMapComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeIn,
        child: bmc.mapC.isSearch.value
            ? SizedBox(
                height: 40.h,
                width: 330.w,
                child: TextFormField(
                  controller: bmc.mapC.searchCntrl.value,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: TextStyle(color: redColor),
                  decoration: InputDecoration(
                    hintText: "Find Location",
                    hintStyle: TextStyle(color: whiteColor),
                    filled: true,
                    fillColor: blackColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: redColor),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: whiteColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        bmc.mapC.isSearch.value = false;
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  onChanged: (value) {},
                  textInputAction: TextInputAction.search,
                ),
              )
            : TransparentContainerComp(
                child: Icon(
                  Icons.search_rounded,
                  color: whiteColor,
                ),
                onTap: () {
                  bmc.mapC.isSearch.value = !bmc.mapC.isSearch.value;
                },
              ),
      );
    });
  }
}
