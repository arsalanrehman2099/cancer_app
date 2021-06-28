import 'package:cancer_spy/firebase/user_helper.dart';
import 'package:cancer_spy/models/user.dart';
import 'package:cancer_spy/screens/dashboard/home_screen.dart';
import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:cancer_spy/widgets/logo_image.dart';
import 'package:cancer_spy/widgets/my_button.dart';
import 'package:cancer_spy/widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  final _email = TextEditingController();
  final _pass = TextEditingController();

  _login(context) async {
    if (_email.text == "") {
      ConstantManager.snackBar('Email is required', context);
    } else if (_pass.text == "") {
      ConstantManager.snackBar('Password is required', context);
    } else if (_pass.text.length < 6) {
      ConstantManager.snackBar(
          'Password must be minimum 6 characters', context);
    } else {
      setState(() => _loading = true);
      User user = User(
        email: _email.text,
        password: _pass.text,
      );
      final response = await UserHelper().userLogin(user);
      setState(() => _loading = false);
      if (response['error'] == 1) {
        ConstantManager.snackBar(response['message'], context);
      } else {
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
          child: Center(
            child: Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _logo(),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3.0),
                    _form(),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
                    MyButton(btnText: 'Login', onClick: () => _login(context)),
                    _creatAcc(context),
                  ],
                ),
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
      ),
    );
  }

  Widget _form() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Log In',
            style: ConstantManager.ktextStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeHorizontal! * 7.5,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
        MyTextField(
          hint: 'Email Address',
          icon: Icons.email,
          controller: _email,
          textInputType: TextInputType.emailAddress,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.2),
        MyTextField(
          hint: 'Password',
          icon: Icons.lock,
          controller: _pass,
          hideText: true,
        )
      ],
    );
  }

  _creatAcc(context) {
    return TextButton(
      onPressed: () =>
          ConstantManager.screenNavigation(context, RegisterScreen()),
      child: Text(
        'Don\'t have an account? Register now!',
        style: ConstantManager.ktextStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
