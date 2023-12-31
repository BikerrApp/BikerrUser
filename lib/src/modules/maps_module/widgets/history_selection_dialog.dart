import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/methods/common_method.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/radio_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistorySelectionDialogComp extends StatelessWidget {
  final BaseController bmc;
  const HistorySelectionDialogComp({
    required this.bmc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          CustomRadioBtnComp(
            value: 0,
            groupValue: bmc.mapC.dc.selectedPeriod.value,
            name: "Today",
            onChanged: (v) {
              bmc.mapC.dc.selectedPeriod.value = v;
            },
          ),
          CustomRadioBtnComp(
            value: 1,
            groupValue: bmc.mapC.dc.selectedPeriod.value,
            name: "Yesterday",
            onChanged: (v) {
              bmc.mapC.dc.selectedPeriod.value = v;
            },
          ),
          CustomRadioBtnComp(
            value: 2,
            groupValue: bmc.mapC.dc.selectedPeriod.value,
            name: "This Week",
            onChanged: (v) {
              bmc.mapC.dc.selectedPeriod.value = v;
            },
          ),
          CustomRadioBtnComp(
            value: 3,
            groupValue: bmc.mapC.dc.selectedPeriod.value,
            name: "Custom",
            onChanged: (v) {
              bmc.mapC.dc.selectedPeriod.value = v;
            },
          ),
          bmc.mapC.dc.selectedPeriod.value == 3
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RedButtonComp(
                          btnName: formatReportDate(
                              bmc.mapC.dc.selectedFromDate.value),
                          onTap: () async {
                            bmc.mapC.dc.selectedFromDate.value =
                                (await showDatePicker(
                              context: Get.context!,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015),
                              lastDate: DateTime(2101),
                            ))!;
                          },
                          isLoading: bmc.mapC.dc.isHistoryLoading,
                          width: 110.w,
                          isSmall: true,
                        ),
                        RedButtonComp(
                          btnName: formatReportTime(
                              bmc.mapC.dc.selectedFromTime.value),
                          onTap: () async {
                            bmc.mapC.dc.selectedFromTime.value =
                                (await showTimePicker(
                              context: Get.context!,
                              initialTime: TimeOfDay.now(),
                            ))!;
                          },
                          isLoading: bmc.mapC.dc.isHistoryLoading,
                          width: 60.w,
                          isSmall: true,
                        ),
                      ],
                    ),
                    5.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RedButtonComp(
                          btnName: formatReportDate(
                              bmc.mapC.dc.selectedToDate.value),
                          onTap: () async {
                            bmc.mapC.dc.selectedToDate.value =
                                (await showDatePicker(
                                    context: Get.context!,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(2101)))!;
                          },
                          isLoading: bmc.mapC.dc.isHistoryLoading,
                          width: 110.w,
                          isSmall: true,
                        ),
                        RedButtonComp(
                          btnName: formatReportTime(
                              bmc.mapC.dc.selectedToTime.value),
                          onTap: () async {
                            bmc.mapC.dc.selectedToTime.value =
                                (await showTimePicker(
                              context: Get.context!,
                              initialTime: TimeOfDay.now(),
                            ))!;
                          },
                          isLoading: bmc.mapC.dc.isHistoryLoading,
                          width: 60.w,
                          isSmall: true,
                        ),
                      ],
                    )
                  ],
                )
              : 0.height,
          15.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RedButtonComp(
                btnName: "OK",
                onTap: () {
                  bmc.mapC.dc.showReport(heading: "Playback");
                },
                width: 100,
                isLoading: bmc.mapC.dc.isHistoryLoading,
              ),
              15.width,
              GestureDetector(
                onTap: () {
                  bmc.mapC.dc.selectedPeriod.value = 0;
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
    });
  }
}
