import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/res/color_res.dart';

extension SnackBarExt on BuildContext {
  //membuat BuildContext punya fungsi2 dibawah ini
  void _showSnackBar(String message, Color bgColor, Color textColor) {
    var snackBar = SnackBar(
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(color : textColor),
        )
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showSuccessSnackBar(String message) => _showSnackBar(message, ColorRes.green, ColorRes.white);

  void showErrorSnackBar(String message) => _showSnackBar(message, ColorRes.red, ColorRes.white);
}