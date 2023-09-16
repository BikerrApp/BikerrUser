import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionListingComp extends StatelessWidget {
  final BaseController bmc;
  const OptionListingComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      mainAxisSpacing: 15.h,
      crossAxisSpacing: 15.w,
      children: [
        ...List.generate(
          bmc.hc.optionList.length,
          (index) => GestureDetector(
            onTap: () {
              bmc.hc.optionsTap(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "${bmc.hc.optionList[index]["icon"]}",
                    height: 60.h,
                  ),
                  MediumTextComp(
                    data: "${bmc.hc.optionList[index]["name"]}",
                    size: 14,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
