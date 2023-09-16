import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController {
  final userIdCntrl = TextEditingController().obs;
  final emailCntrl = TextEditingController().obs;

  final isForgot = false.obs;
}
