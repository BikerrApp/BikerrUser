import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataPopUpComp extends StatelessWidget {
  const NoDataPopUpComp({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLoading = false.obs;
    return Column(
      children: [
        const MediumTextComp(
          data: "OOPS! No data is available for the selected date",
          size: 15,
        ),
        15.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RedButtonComp(
              btnName: "OK",
              onTap: () {
                Get.back();
                Get.back();
              },
              width: 100,
              isLoading: isLoading,
            ),
            15.width,
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const MediumTextComp(
                data: "Cancel",
                size: 15,
              ),
            )
          ],
        )
      ],
    );
  }
}
