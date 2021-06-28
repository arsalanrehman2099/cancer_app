import 'dart:convert';

import 'package:cancer_spy/firebase/patient_helper.dart';
import 'package:cancer_spy/models/patient.dart';
import 'package:cancer_spy/services/prediction_services.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/header.dart';
import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:cancer_spy/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  TextEditingController _tName = TextEditingController();
  TextEditingController _tAge = TextEditingController();

  var CDH1 = "";
  var PTEN = "";
  var TP53 = "";
  var ATM = "";
  var ATM_1 = "";
  var ATM_2 = "";
  var NBN = "";
  var NBN_1 = "";
  var NBN_2 = "";
  var AKT1 = "";
  var BRCA1 = "";
  var BRCA2 = "";
  var BRCA2_1 = "";
  var BRCA2_2 = "";
  var BRCA2_3 = "";

  var list_CDH1 = ['CC', 'TC', 'TT'];
  var list_PTEN = ['CC', 'CT', 'TT'];
  var list_TP53 = ['CC', 'TC', 'TT'];
  var list_ATM = ['AA', 'GA', 'GG'];
  var list_ATM_1 = ['CC', 'TC', 'TT'];
  var list_ATM_2 = ['GT', 'TT', 'GG'];
  var list_NBN = ['AA', 'AG', 'GG'];
  var list_NBN_1 = ['CC', 'CG', 'GG'];
  var list_NBN_2 = ['AA', 'GA', 'GG'];
  var list_AKT1 = ['AA', 'CA', 'CC'];
  var list_BRCA1 = ['AA', 'GA', 'GG'];
  var list_BRCA2 = ['AA', 'AG', 'GG'];
  var list_BRCA2_1 = ['AA', 'CA', 'CC'];
  var list_BRCA2_2 = ['AA', 'CA', 'CC'];
  var list_BRCA2_3 = ['AA', 'AG', 'GG'];

  bool _loading = false;

  _submit() async {
    if (_tName.text == "" ||
        _tAge.text == "" ||
        CDH1 == "" ||
        PTEN == "" ||
        TP53 == "" ||
        ATM == "" ||
        ATM_1 == "" ||
        ATM_2 == "" ||
        NBN == "" ||
        NBN_1 == "" ||
        NBN_2 == "" ||
        AKT1 == "" ||
        BRCA1 == "" ||
        BRCA2 == "" ||
        BRCA2_1 == "" ||
        BRCA2_2 == "" ||
        BRCA2_3 == "") {
      ConstantManager.snackBar('Please fill all fields', context);
    } else {
      setState(() => _loading = true);

      Patient patient = Patient(
          name: _tName.text,
          age: _tAge.text,
          CDH1: CDH1,
          PTEN: PTEN,
          TP53: TP53,
          ATM: ATM,
          ATM_1: ATM_1,
          ATM_2: ATM_2,
          NBN: NBN,
          NBN_1: NBN_1,
          NBN_2: NBN_2,
          AKT1: AKT1,
          BRCA1: BRCA1,
          BRCA2: BRCA2,
          BRCA2_1: BRCA2_1,
          BRCA2_2: BRCA2_2,
          BRCA2_3: BRCA2_3);

      final response = await PredictionApiServices.prediction(patient.toJson());
      patient.predictionScore = response['prediction'];

      if (response['error'] == 1) {
        ConstantManager.snackBar(response['message'], context);
      } else {
        setState(() => _loading = false);

        //  show dialog
        _resultDialog(patient.predictionScore);

        //  save data
        final response = await PatientHelper().submitPredictionData(patient);
        if (response['error'] == 1) {
          ConstantManager.snackBar(response['message'], context);
        } else {
          _emptyTextFields();
        }
      }
    }
  }

  _resultDialog(prediction) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  prediction > 50
                      ? Icons.dangerous
                      : Icons.assignment_turned_in,
                  color: prediction > 50 ? Colors.red : Colors.green,
                  size: 100.0,
                ),
                Text(
                  prediction > 50 ? 'HIGH RISK' : 'LOW RISK',
                  style: ConstantManager.ktextStyle.copyWith(
                      color: prediction > 50 ? Colors.red : Colors.green,
                      fontSize: 22.0),
                ),
                SizedBox(height: 5.0),
                Text(
                  "RESULT: " + prediction.toStringAsFixed(0) + "%",
                  style: ConstantManager.ktextStyle
                    ..copyWith(
                        color: prediction > 50 ? Colors.red : Colors.green,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        });
  }

  _emptyTextFields() {
    _tName.text = "";
    _tAge.text = "";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar(),
      body: LoadingOverlay(
        color: ConstantManager.PRIMARY_COLOR,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
        isLoading: _loading,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.5),
            margin: EdgeInsets.all(SizeConfig.blockSizeVertical! * 1.5),
            width: double.infinity,
            decoration: ConstantManager.getBoxDecoration(),
            child: Column(
              children: [
                LogoImage(imagePath: ConstantManager.BLUE_LOGO_PATH),
                SizedBox(height: SizeConfig.blockSizeVertical),
                Header('New Prediction'),
                Divider(),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _textField(label: 'Name', ctlr: _tName),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _textField(
                    label: 'Age', ctlr: _tAge, inputType: TextInputType.number),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _dropdownRow({
                  'label': 'CDH1',
                  'list': list_CDH1,
                  'key': CDH1,
                }, {
                  'label': 'PTEN',
                  'list': list_PTEN,
                  'key': PTEN,
                }),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _dropdownRow({
                  'label': 'TP53',
                  'list': list_TP53,
                  'key': TP53,
                }, {
                  'label': 'ATM',
                  'list': list_ATM,
                  'key': ATM,
                }),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _dropdownRow({
                  'label': 'ATM_1',
                  'list': list_ATM_1,
                  'key': ATM_1,
                }, {
                  'label': 'ATM_2',
                  'list': list_ATM_2,
                  'key': ATM_2,
                }),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _dropdownRow({
                  'label': 'NBN',
                  'list': list_NBN,
                  'key': NBN,
                }, {
                  'label': 'NBN_1',
                  'list': list_NBN_1,
                  'key': NBN_1,
                }),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _dropdownRow({
                  'label': 'NBN_2',
                  'list': list_NBN_2,
                  'key': NBN_2,
                }, {
                  'label': 'AKT1',
                  'list': list_AKT1,
                  'key': AKT1,
                }),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _dropdownRow({
                  'label': 'BRCA1',
                  'list': list_BRCA1,
                  'key': BRCA1,
                }, {
                  'label': 'BRCA2',
                  'list': list_BRCA2,
                  'key': BRCA2,
                }),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _dropdownRow({
                  'label': 'BRCA2_1',
                  'list': list_BRCA2_1,
                  'key': BRCA2_1,
                }, {
                  'label': 'BRCA2_2',
                  'list': list_BRCA2_2,
                  'key': BRCA2_2,
                }),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                _mydropdown(label: 'BRCA2_3', list: list_BRCA2_3),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
                MyButton(
                  btnText: 'Predict',
                  onClick: () => _submit(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({label, ctlr, inputType = TextInputType.text}) {
    return TextField(
      controller: ctlr,
      keyboardType: inputType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelText: label,
        fillColor: Colors.white,
        labelStyle: ConstantManager.ktextStyle
            .copyWith(color: ConstantManager.PRIMARY_COLOR.withOpacity(0.8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
              new BorderSide(width: 1, color: ConstantManager.PRIMARY_COLOR),
        ),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5.0),
          borderSide:
              new BorderSide(width: 1, color: ConstantManager.PRIMARY_COLOR),
        ),
      ),
    );
  }

  Widget _dropdownRow(dd1, dd2) {
    return Row(
      children: [
        Expanded(child: _mydropdown(label: dd1['label'], list: dd1['list'])),
        SizedBox(width: SizeConfig.blockSizeHorizontal! * 1.5),
        Expanded(child: _mydropdown(label: dd2['label'], list: dd2['list'])),
      ],
    );
  }

  Widget _mydropdown({label, list}) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        labelText: label,
        fillColor: Colors.white,
        labelStyle: ConstantManager.ktextStyle
            .copyWith(color: ConstantManager.PRIMARY_COLOR.withOpacity(0.8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide:
              new BorderSide(width: 1, color: ConstantManager.PRIMARY_COLOR),
        ),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5.0),
          borderSide:
              new BorderSide(width: 1, color: ConstantManager.PRIMARY_COLOR),
        ),
      ),
      items: list.map<DropdownMenuItem<Object>>((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
            style: ConstantManager.ktextStyle
                .copyWith(color: ConstantManager.SECONDARY_COLOR),
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          if (label == "CDH1")
            CDH1 = val.toString();
          else if (label == "PTEN")
            PTEN = val.toString();
          else if (label == "TP53")
            TP53 = val.toString();
          else if (label == "ATM")
            ATM = val.toString();
          else if (label == "ATM_1")
            ATM_1 = val.toString();
          else if (label == "ATM_2")
            ATM_2 = val.toString();
          else if (label == "NBN")
            NBN = val.toString();
          else if (label == "NBN_1")
            NBN_1 = val.toString();
          else if (label == "NBN_2")
            NBN_2 = val.toString();
          else if (label == "AKT1")
            AKT1 = val.toString();
          else if (label == "BRCA1")
            BRCA1 = val.toString();
          else if (label == "BRCA2")
            BRCA2 = val.toString();
          else if (label == "BRCA2_1")
            BRCA2_1 = val.toString();
          else if (label == "BRCA2_2")
            BRCA2_2 = val.toString();
          else if (label == "BRCA2_3") BRCA2_3 = val.toString();
        });
      },
    );
  }
}
