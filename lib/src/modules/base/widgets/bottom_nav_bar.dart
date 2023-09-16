import 'package:bikerr_partner_app/src/modules/base/controllers/base_controller.dart';
import 'package:bikerr_partner_app/src/utils/strings/colors.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class BaseBottomNavComp extends StatelessWidget {
  final BaseController bmc;
  const BaseBottomNavComp({
    required this.bmc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 70.h,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(homeIcon)),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(mapIcon)),
              label: "Track",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_outlined),
              label: "Profile",
            ),
          ],
          onTap: bmc.onItemTap,
          currentIndex: bmc.onTapChangePageIndex.value,
          backgroundColor: dGreyColor,
          selectedItemColor: redColor,
          unselectedItemColor: lGreyColor,
          selectedIconTheme: IconThemeData(color: redColor),
          unselectedIconTheme: IconThemeData(color: lGreyColor),
          iconSize: 26,
        ),
      );
    });
  }
}
