import 'package:bikerr_partner_app/src/modules/maps_module/controllers/add_geofence_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/toast.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class AddGeofenceSetupComp extends StatelessWidget {
  final AddGeofenceController gac;
  const AddGeofenceSetupComp({
    required this.gac,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return gac.addFenceVisible.value
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Container(
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.all(10.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextfieldComp(
                        title: "Geofence Name",
                        controller: gac.fenceName.value,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        hintText: "Enter Geofence Name",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MediumTextComp(data: "Radius", size: 12.sp),
                          Slider(
                            value: gac.valRadius.value,
                            min: 100,
                            max: 10000,
                            onChanged: (v) {
                              gac.valRadius.value = v;
                              gac.mapController.value!.updateCircle(
                                gac.circle.value!,
                                CircleOptions(circleRadius: v / 10),
                              );
                            },
                            thumbColor: redColor,
                            activeColor: redColor,
                          ),
                          MediumTextComp(
                            data: "${gac.valRadius.value.toInt()}",
                            size: 12.sp,
                          ),
                        ],
                      ),
                      RedButtonComp(
                        btnName: "Add Geofence",
                        onTap: () async {
                          if (gac.fenceName.value.value.text
                              .trim()
                              .isNotEmpty) {
                            await gac.submitFence();
                          } else {
                            getToast("Please enter a Geofence name");
                          }
                        },
                        isLoading: gac.isLoading,
                      )
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox();
    });
  }
}
