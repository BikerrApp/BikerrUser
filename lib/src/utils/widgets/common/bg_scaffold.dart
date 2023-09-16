import 'package:bikerr_partner_app/src/utils/strings/images.dart';
import 'package:bikerr_partner_app/src/utils/widgets/buttons/back_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget child;
  final bool isBackBtn;
  const BackgroundScaffold({
    required this.child,
    this.appBar,
    this.isBackBtn = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              bgImage,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: child,
          ),
          isBackBtn
              ? Positioned(top: 10.h, left: 10.w, child: const BackButtonComp())
              : const SizedBox(),
        ],
      ),
    );
  }
}
