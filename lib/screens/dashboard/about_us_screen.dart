import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/header.dart';
import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final String about =
      'The breast cancer prediction app is a simulator to predict abnormal disease between the individuals using their genomic extracted data. The aim of this app is to provide ease in the industry of medical researchers.The prediction app was developed after studying many outcomes in the society where breast cancer ratio is above 24% in South Asia and Breast cancer is one of the major diseases people are facing nowadays, researchers have focused on particulars genes including BRCA1 & BRCA2 which are the most common genes abnormility found in breast cancer.The app ensures the safety platform whereas, it is useful in handy with userfriendly environment.';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.5),
          margin: EdgeInsets.all(SizeConfig.blockSizeVertical! * 1.5),
          width: double.infinity,
          decoration: ConstantManager.getBoxDecoration(),
          child: Column(
            children: [
              LogoImage(imagePath: ConstantManager.BLUE_LOGO_PATH),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
              Header('About us'),
              Divider(),
              SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
              Text(
                about,
                style: ConstantManager.ktextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            ],
          ),
        ),
      ),
    );
  }
}
