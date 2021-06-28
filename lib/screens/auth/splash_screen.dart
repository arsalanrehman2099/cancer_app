import 'dart:async';

import 'package:cancer_spy/firebase/user_helper.dart';
import 'package:cancer_spy/screens/dashboard/home_screen.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _version = "";

  @override
  void initState() {
    super.initState();

    _getVersionNumber();

    Timer(
      Duration(seconds: 2),
          () => ConstantManager.screenNavWithClear(
        context,
        UserHelper().isLoggedIn() ? HomeScreen() : LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ConstantManager.PRIMARY_COLOR,
      body: Stack(
        children: [
          _splashLogo(),
          _versionText(),
        ],
      ),
    );
  }

  Widget _splashLogo(){
    return Center(child: LogoImage(imagePath: ConstantManager.WHITE_LOGO_PATH));
  }

  Widget _versionText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Version ' + _version.toString(),
          style: ConstantManager.ktextStyle.copyWith(
            color: Colors.white,
            letterSpacing: 1.0,
            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
          ),
        ),
      ),
    );
  }

  _getVersionNumber() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() => _version = packageInfo.version);
    });
  }
}

// Email => developer.cancerspy@gmail.com
// Password => Rohab123@