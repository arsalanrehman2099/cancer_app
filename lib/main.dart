import 'package:cancer_spy/screens/auth/splash_screen.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Cancer Spy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ConstantManager.PRIMARY_COLOR,
        accentColor: ConstantManager.SECONDARY_COLOR,
      ),
      home: SplashScreen(),
    );
  }
}
