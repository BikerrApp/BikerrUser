import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/controllers/geo_fence_controller.dart';
import 'package:bikerr_partner_app/src/modules/maps_module/screens/geofence_screen.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';

import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/dialog_box.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/thin_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FenceCardComp extends StatelessWidget {
  final GeoFenceController gc;
  final int index;
  const FenceCardComp({
    required this.gc,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: greyColor,
      leading: Obx(() {
        return Checkbox(
          side: BorderSide(color: dGreyColor),
          activeColor: redColor,
          checkColor: dGreyColor,
          value: gc.fenceCheckboxValue(fenceId: gc.fenceList[index].id!),
          onChanged: (v) {
            gc.fenceCheckboxChange(v, gc.fenceList[index].id);
          },
        );
      }),
      title: MediumTextComp(
        data: "${gc.fenceList[index].name}",
        size: 16.sp,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: whiteColor,
        ),
        onPressed: () {
          dialogBox(
            title: "Delete Fence",
            centerChild: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ThinTextComp(
                  data: "Are you sure?",
                  isCenter: true,
                ),
                15.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RedButtonComp(
                      btnName: "Yes",
                      onTap: () {
                        gc.deleteFence(gc.fenceList[index].id);
                      },
                      width: 100,
                      isLoading: gc.isDeleteFenceLoading,
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
            ),
          );
        },
      ),
      onTap: () {
        Get.to(() => GeofenceScreen(gc: gc, index: index));
      },
    );
  }
}
