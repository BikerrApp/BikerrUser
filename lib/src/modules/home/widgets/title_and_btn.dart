import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';

import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/widgets/texts/medium_text_comp.dart';
import 'package:flutter/material.dart';

class TitleAndButtonComp extends StatelessWidget {
  final BaseController bmc;
  const TitleAndButtonComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const MediumTextComp(
          data: "Booked and Taken",
          size: 18,
        ),
        TextButton(
          onPressed: () {},
          child: MediumTextComp(
            data: "View All",
            color: redColor,
            size: 14,
          ),
        ),
      ],
    );
  }
}
