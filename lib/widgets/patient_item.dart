import 'package:cancer_spy/models/patient.dart';
import 'package:cancer_spy/screens/dashboard/patient_info_screen.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:flutter/material.dart';

class PatientItem extends StatelessWidget {
  final Patient patient;

  PatientItem(this.patient);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () => {
        ConstantManager.screenNavigation(context, PatientInfoScreen(patient))
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.2)
            ],
            borderRadius: BorderRadius.circular(25.0)),
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              'ID#${ConstantManager.generateRandomString(5)}',
              style: ConstantManager.ktextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: ConstantManager.PRIMARY_COLOR,
              ),
            ),
            Expanded(
              child: Icon(
                Icons.account_circle,
                size: SizeConfig.blockSizeVertical! * 15.0,
                color: ConstantManager.SECONDARY_COLOR,
              ),
            ),
            Text(
              patient.name ?? "",
              style: ConstantManager.ktextStyle,
            ),
            Text(
              "${patient.age} yrs",
              style: ConstantManager.ktextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
