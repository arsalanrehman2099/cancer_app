import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:cancer_spy/utils/size_config.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final text;

  Header(this.text);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);


    return Center(
      child: Text(
        text.toUpperCase(),
        style: ConstantManager.ktextStyle.copyWith(
          color: ConstantManager.PRIMARY_COLOR,
          fontSize: SizeConfig.blockSizeHorizontal! * 7.0,
          letterSpacing: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
