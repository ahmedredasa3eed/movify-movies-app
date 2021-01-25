import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  static showAlertDialog(BuildContext context, String title, String desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkColor: Color(0xff0f0c29),
      buttonsBorderRadius: BorderRadius.circular(10),
      headerAnimationLoop: true,
      btnOkOnPress: () {},
    )..show();
  }
}
