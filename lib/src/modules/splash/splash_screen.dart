import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bikerr_partner_app/src/modules/auth/login/login.dart';
import 'package:bikerr_partner_app/src/modules/base/base_class.dart';
import 'package:bikerr_partner_app/src/utils/strings/icons.dart';
import 'package:bikerr_partner_app/src/utils/strings/images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final bool isLogin;
  const SplashScreen({required this.isLogin, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Transform.scale(
            scale: 1.08,
            child: Image.asset(splashBg),
          ),
        ),
        AnimatedSplashScreen(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          splash: AnimatedContainer(
            duration: const Duration(milliseconds: 1700),
            curve: Curves.easeIn,
            child: Image.asset(bikerrLogo),
          ),
          duration: 2000,
          nextScreen:
              isLogin ? const BaseClass() : const LoginScreen(),
        )
      ],
    );
  }
}
