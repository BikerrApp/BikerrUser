import 'package:bikerr_partner_app/src/extensions/space_ext.dart';
import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/red_btn.dart';
import 'package:bikerr_partner_app/src/utils/widgets/common/text_field.dart';
import 'package:flutter/material.dart';

class AddDeviceFormComp extends StatelessWidget {
  final BaseController bmc;
  const AddDeviceFormComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextfieldComp(
            title: "Bike Name",
            controller: bmc.mapC.dc.bikeNameCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hintText: "Enter Bike Name",
          ),
          25.height,
          CustomTextfieldComp(
            title: "Device Unique Id",
            controller: bmc.mapC.dc.uniqueIdCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: const TextInputType.numberWithOptions(
                decimal: false, signed: false),
            hintText: "Enter Device Uniq Id",
          ),
          25.height,
          CustomTextfieldComp(
            title: "Mobile Number",
            controller: bmc.mapC.dc.mobileNumberCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: const TextInputType.numberWithOptions(
                decimal: false, signed: false),
            hintText: "Enter Mobile Number",
          ),
          25.height,
          CustomTextfieldComp(
            title: "Device Model",
            controller: bmc.mapC.dc.deviceModelCntrl.value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hintText: "Enter Device Model",
          ),
          25.height,
          CustomTextfieldComp(
            title: "Device Contact",
            controller: bmc.mapC.dc.deviceContactCntrl.value,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            hintText: "Enter Device Contact",
          ),
          70.height,
          RedButtonComp(
            btnName: "Add Device",
            onTap: () {
              bmc.mapC.dc.addNewDevice();
            },
            isLoading: bmc.mapC.dc.isAddingDevice,
          ),
        ],
      ),
    );
  }
}
