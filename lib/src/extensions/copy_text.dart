import 'package:flutter/services.dart';

copyText({required String text}) {
  final value = ClipboardData(text: text);
  Clipboard.setData(value);
}
