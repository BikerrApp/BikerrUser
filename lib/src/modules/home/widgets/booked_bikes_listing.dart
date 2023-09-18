import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/bike_details.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';

class BookedBikesListingComp extends StatelessWidget {
  final BaseController bmc;
  final int listLength;
  final List list;
  const BookedBikesListingComp({
    required this.bmc,
    required this.listLength,
    required this.list,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
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
  }
}
