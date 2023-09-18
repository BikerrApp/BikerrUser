import 'package:bikerr_partner_app/src/modules/add_bikes/widgets/add_bike_images.dart';
import 'package:bikerr_partner_app/src/modules/add_bikes/widgets/address_details_form.dart';
import 'package:bikerr_partner_app/src/modules/add_bikes/widgets/bike_details_form.dart';
import 'package:bikerr_partner_app/src/modules/add_bikes/widgets/bike_insurance_form.dart';
import 'package:bikerr_partner_app/src/modules/add_bikes/widgets/bike_pollution_form.dart';
import 'package:bikerr_partner_app/src/modules/add_bikes/widgets/bike_registration_form.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/modules/add_bikes/widgets/info_container.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBikeModule extends StatelessWidget {
  final BaseController bmc;
  const AddBikeModule({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Add Bike"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bmc.ac.isDocumentInfo.value
                ? [
                    InfoRowItemComp(bmc: bmc),
                    BikeRegistrationFormComp(bmc: bmc),
                    BikeInsuranceFormComp(bmc: bmc),
                    BikePollutionFormComp(bmc: bmc),
                  ]
                : [
                    InfoRowItemComp(bmc: bmc),
                    BikeDetailsFormComp(bmc: bmc),
                    AddressDetailsFormComp(bmc: bmc),
                    AddBikeImagesComp(bmc: bmc),
                  ],
          );
        }),
      ),
    );
  }
}
