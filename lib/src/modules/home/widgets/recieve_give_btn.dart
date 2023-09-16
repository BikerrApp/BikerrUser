import 'package:bikerr_partner_app/src/utils/widgets/buttons/grey_btn.dart';
import 'package:flutter/material.dart';

class RecieveGiveBtnComp extends StatelessWidget {
  final bool isRecieve;
  const RecieveGiveBtnComp({required this.isRecieve, super.key});

  @override
  Widget build(BuildContext context) {
    return GreyButton(
      btnName: isRecieve ? "Recieve Bike" : "Bike Given",
      onTap: () {},
    );
  }
}
