import 'package:cancer_spy/firebase/patient_helper.dart';
import 'package:cancer_spy/models/patient.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/header.dart';
import 'package:cancer_spy/widgets/loader.dart';
import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:cancer_spy/widgets/my_drawer.dart';
import 'package:cancer_spy/widgets/patient_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Patient> patients = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _readData();
  }

  _readData() async {
    setState(() => _loading = true);

    final response = await PatientHelper().getPatientData();

    if (response['error'] == 1) {
      ConstantManager.snackBar(response['message'], context);
    } else {
      patients = response['data'];
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      drawer: MyDrawer(),
      appBar: _appBar(),
      body: _loading
          ? Loader()
          : patients.length == 0
              ? _noPatientFound()
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical! * 2.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Header('Dashboard'),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal! * 2.0,
                                  vertical: SizeConfig.blockSizeVertical!),
                              child: GridView.count(
                                primary: false,
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                children: List.generate(patients.length,
                                    (i) => PatientItem(patients[i])),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  _noPatientFound() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_sharp,
            color: ConstantManager.PRIMARY_COLOR,
            size: SizeConfig.blockSizeHorizontal! * 10.0,
          ),
          Text(
            'No Patient\'s\nFound',
            textAlign: TextAlign.center,
            style: ConstantManager.ktextStyle.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal! * 7.0,
                color: ConstantManager.PRIMARY_COLOR),
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: ConstantManager.PRIMARY_COLOR,
      title: LogoImage(
          imagePath: ConstantManager.WHITE_LOGO_PATH, h: 30.0, w: 30.0),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _readData)
      ],
    );
  }
}
