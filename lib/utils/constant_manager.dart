import 'dart:math';

import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstantManager {
  static const PRIMARY_COLOR = Color(0xFF98ccfd);
  static const SECONDARY_COLOR = Color(0xFF4788c7);

  static const WHITE_LOGO_PATH = 'assets/logo/logo_white.png';
  static const BLUE_LOGO_PATH = 'assets/logo/logo_blue.png';
  static const DARK_LOGO_PATH = 'assets/logo/logo_dark.png';

  static var ktextStyle = GoogleFonts.ubuntu();
  static var htextStyle = GoogleFonts.lobsterTwo();

  static AppBar appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: ConstantManager.PRIMARY_COLOR,
      title: LogoImage(
          imagePath: ConstantManager.WHITE_LOGO_PATH, h: 30.0, w: 30.0),
      centerTitle: true,
    );
  }

  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  static void screenNavigation(context, route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  static void screenNavWithClear(context, route) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => route,
      ),
      (route) => false,
    );
  }

  static showtoast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.white,
      textColor: Colors.grey.shade900,
    );
  }

  static snackBar(String? message, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
