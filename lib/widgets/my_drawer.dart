import 'package:cancer_spy/screens/auth/login_screen.dart';
import 'package:cancer_spy/screens/dashboard/about_us_screen.dart';
import 'package:cancer_spy/screens/dashboard/prediction_screen.dart';
import 'package:cancer_spy/screens/dashboard/profile_screen.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Drawer(
      child: Container(
        color: ConstantManager.PRIMARY_COLOR,
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical! * 10.0),
        child: Column(
          children: [
            LogoImage(
              imagePath: ConstantManager.WHITE_LOGO_PATH,
              h: SizeConfig.blockSizeVertical! * 10.0,
              w: SizeConfig.blockSizeVertical! * 10.0,
            ),
            SizedBox(height: 20.0),
            Divider(color: Colors.white),
            _drawerTile('Dashboard', Icons.home, () => Navigator.pop(context)),
            _drawerTile(
                'Profile',
                Icons.account_circle,
                () =>
                    ConstantManager.screenNavigation(context, ProfileScreen())),
            _drawerTile(
                'New Prediction',
                Icons.add_box,
                () => ConstantManager.screenNavigation(
                    context, PredictionScreen())),
            _drawerTile('About us', Icons.app_settings_alt_rounded,
                () => ConstantManager.screenNavigation(context, AboutScreen())),
            _drawerTile('Logout', Icons.logout, () {
              FirebaseAuth.instance.signOut().then((value) =>
                  {ConstantManager.screenNavigation(context, LoginScreen())});
            }),
          ],
        ),
      ),
    );
  }

  _drawerTile(text, icon, onClick) {
    return ListTile(
      onTap: onClick,
      title: Text(
        text,
        style: ConstantManager.ktextStyle.copyWith(
          color: Colors.white,
          fontSize: SizeConfig.blockSizeHorizontal! * 5.0,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
