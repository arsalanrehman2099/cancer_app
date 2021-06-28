import 'package:cancer_spy/utils/constant_manager.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final IconData? icon;
  final TextInputType textInputType;
  final bool hideText;

  MyTextField(
      {this.controller,
      this.hint,
      this.icon,
      this.hideText = false,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantManager.getBoxDecoration()
          .copyWith(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: ListTile(
        title: TextField(
          controller: controller,
          obscureText: hideText,
          cursorColor: ConstantManager.PRIMARY_COLOR,
          keyboardType: textInputType,
          decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint,
            hintStyle: ConstantManager.ktextStyle.copyWith(
              color: ConstantManager.PRIMARY_COLOR,
            ),
          ),
        ),
        leading: Icon(
          icon,
          color: ConstantManager.PRIMARY_COLOR,
        ),
      ),
    );
  }
}
