import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/bike_details.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookedBikesListingComp extends StatelessWidget {
  final BaseController bmc;
  final int listLength;
  final List list;
  final RxBool isLoading;
  const BookedBikesListingComp({
    required this.bmc,
    required this.listLength,
    required this.list,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return isLoading.value
          ? CircularProgressIndicator(color: redColor)
          : list.isNotEmpty
              ? Column(
                  children: [
                    ...List.generate(
                      listLength,
                      (index) => BikeDetailsComp(bmc: bmc),
                    ),
                  ],
                )
              : Center(
                  child: MediumTextComp(
                    data: "No Data Available",
                    color: whiteColor,
                  ),
                );
    });
  }
}
