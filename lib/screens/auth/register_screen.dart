import 'package:cancer_spy/firebase/user_helper.dart';
import 'package:cancer_spy/models/user.dart';
import 'package:cancer_spy/screens/dashboard/home_screen.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:cancer_spy/widgets/my_button.dart';
import 'package:cancer_spy/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _loading = false;

  final _tName = TextEditingController();
  final _tEmail = TextEditingController();
  final _tPass = TextEditingController();
  final _tCfmPass = TextEditingController();
  final _tContact = TextEditingController();

  _signup(context) async {
    if (_tName.text == "") {
      ConstantManager.snackBar('Name is required', context);
    } else if (_tEmail.text == "") {
      ConstantManager.snackBar('Email is required', context);
    } else if (_tPass.text == "") {
      ConstantManager.snackBar('Password is required', context);
    } else if (_tPass.text.length < 6) {
      ConstantManager.snackBar(
          'Password must be minimum 6 characters', context);
    } else if (_tCfmPass.text == "") {
      ConstantManager.snackBar('Confirm password is required', context);
    } else if (_tPass.text != _tCfmPass.text) {
      ConstantManager.snackBar('Password Does not match', context);
    } else if (_tContact.text == "") {
      ConstantManager.snackBar('Contact is required', context);
    } else {
      setState(() => _loading = true);

      User user = User(
        name: _tName.text,
        email: _tEmail.text,
        password: _tPass.text,
        contact: _tContact.text,
      );

      final response = await UserHelper().userSignup(user);
      setState(() => _loading = false);
      if (response['error'] == 1) {
        ConstantManager.snackBar(response['message'], context);
      } else {
        ConstantManager.snackBar('Registration Successful', context);
        ConstantManager.screenNavWithClear(context, HomeScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ConstantManager.PRIMARY_COLOR,
      body: LoadingOverlay(
        color: ConstantManager.PRIMARY_COLOR,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
        isLoading: _loading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal! * 3.0,
                  vertical: SizeConfig.blockSizeVertical! * 4.5),
              child: Column(
                children: [
                  _logo(),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 3.0),
                  _form(),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
                  MyButton(btnText: 'Sign up', onClick: () => _signup(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
        child: LogoImage(
      imagePath: ConstantManager.WHITE_LOGO_PATH,
    ));
  }

  Widget _form() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sign Up',
            style: ConstantManager.ktextStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeHorizontal! * 7.5,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
        MyTextField(
          hint: 'Full Name',
          icon: Icons.account_circle,
          controller: _tName,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.2),
        MyTextField(
          hint: 'Email Address',
          icon: Icons.email,
          controller: _tEmail,
          textInputType: TextInputType.emailAddress,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.2),
        MyTextField(
          hint: 'Password',
          icon: Icons.lock,
          controller: _tPass,
          hideText: true,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.2),
        MyTextField(
          hint: 'Confirm Password',
          icon: Icons.lock,
          controller: _tCfmPass,
          hideText: true,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.2),
        MyTextField(
          hint: 'Contact',
          icon: Icons.phone_android,
          controller: _tContact,
          textInputType: TextInputType.number,
        ),
      ],
    );
  }
}
