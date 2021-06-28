import 'package:cancer_spy/firebase/user_helper.dart';
import 'package:cancer_spy/models/user.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/header.dart';
import 'package:cancer_spy/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loading = true;

  User? user;

  _readData() async {
    setState(() => _loading = true);

    final response = await UserHelper().getUserData();
    setState(() => _loading = false);
    if (response['error'] == 1) {
      ConstantManager.snackBar(response['message'], context);
    } else {
      setState(() => user = response['data']);
    }
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar(),
      body: _loading
          ? Loader()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.5),
                margin: EdgeInsets.all(SizeConfig.blockSizeVertical! * 1.5),
                width: double.infinity,
                decoration: ConstantManager.getBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        Icons.account_circle,
                        color: ConstantManager.PRIMARY_COLOR,
                        size: SizeConfig.blockSizeHorizontal! * 35.0,
                      ),
                    ),
                    Header('My Profile'),
                    Divider(),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                    userInfo('ID#', user?.id!.substring(0, 10) ?? ""),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
                    userInfo('Name', user?.name ?? ""),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
                    userInfo('Email', user?.email ?? ""),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
                    userInfo('Password', '*******'),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
                    userInfo('Contact', user?.contact ?? ""),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
                  ],
                ),
              ),
            ),
    );
  }

  Widget userInfo(key, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: ConstantManager.ktextStyle.copyWith(
              color: ConstantManager.SECONDARY_COLOR,
              fontSize: SizeConfig.blockSizeHorizontal! * 4.0,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical),
        Text(
          value,
          style: ConstantManager.ktextStyle.copyWith(
            fontSize: SizeConfig.blockSizeHorizontal! * 4.2,
          ),
        ),
      ],
    );
  }
}
