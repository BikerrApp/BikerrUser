import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/home/widgets/bike_details.dart';
import 'package:flutter/material.dart';

class BookedBikesListingComp extends StatelessWidget {
  final BaseController bmc;
  final int listLength;
  const BookedBikesListingComp({required this.bmc,required this.listLength, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          listLength,
          (index) => BikeDetailsComp(bmc: bmc),
        ),
      ],
    );
  }
}
