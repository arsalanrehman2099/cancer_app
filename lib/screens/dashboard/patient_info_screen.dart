import 'package:cancer_spy/models/patient.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/header.dart';
import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:flutter/material.dart';

class PatientInfoScreen extends StatelessWidget {
  final Patient patient;

  PatientInfoScreen(this.patient);

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
              SizedBox(height: SizeConfig.blockSizeVertical),
              Header('Patient History'),
              Divider(),
              SizedBox(height: SizeConfig.blockSizeVertical),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('Name', patient.name),
                  _userInfo('Age', patient.age)
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('CDH1', patient.CDH1),
                  _userInfo('PTEN', patient.PTEN),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('TP53', patient.TP53),
                  _userInfo('ATM (2)', patient.ATM_2),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('ATM (1)', patient.ATM_1),
                  _userInfo('ATM', patient.ATM),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('NBN (1)', patient.NBN_1),
                  _userInfo('NBN (2)', patient.NBN_2),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('AKT1', patient.AKT1),
                  _userInfo('BRCA1', patient.BRCA1),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('BRCA2', patient.BRCA2),
                  _userInfo('BRCA2 (1)', patient.BRCA2_1),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('BRCA2 (2)', patient.BRCA2_2),
                  _userInfo('BRCA2 (3)', patient.BRCA2_3),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _userInfo('NBN', patient.NBN),
                ],
              ),
              Divider(),
              Text(
                (patient.predictionScore! > 50 ? 'HIGH' : 'LOW') +
                    ' risk of breast cancer'.toUpperCase(),
                textAlign: TextAlign.center,
                style: ConstantManager.ktextStyle.copyWith(
                    color: patient.predictionScore! > 50
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeHorizontal! * 5.0,
                    letterSpacing: 0.5),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInfo(key, value) {
    return Row(
      children: [
        Text(
          key + ":",
          style: ConstantManager.ktextStyle.copyWith(
              color: ConstantManager.SECONDARY_COLOR,
              fontSize: 14.0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 8.0),
        Text(
          value,
          style: ConstantManager.ktextStyle.copyWith(fontSize: 16.0),
        ),
      ],
    );
  }
}
