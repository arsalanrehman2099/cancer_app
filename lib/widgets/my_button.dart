import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? btnText;
  final void Function()? onClick;

  MyButton({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        decoration: BoxDecoration(
            color: ConstantManager.SECONDARY_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        width: double.infinity,
        child: Text(
          btnText!.toUpperCase(),
          style: ConstantManager.ktextStyle
              .copyWith(color: Colors.white, letterSpacing: 1),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
