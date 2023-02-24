// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:klicks_vendor/values/colors.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.obscure = false,
      this.onChange,
      this.imageIcon,
      this.validator,
      this.autovalidateMode,
      this.validate,
      this.icon,
      this.type = TextInputType.text,
      this.fontSize = 14.0,
      this.width = 0.98,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final bool? validate;
  final hint;
  final width;
  final type;
  final imageIcon;
  final icon;
  final obscure;
  final text;
  final autovalidateMode;
  final maxlines;
  final onChange;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * width,
      child: TextFormField(
        readOnly: readOnly,
        enabled: enabled,
        obscureText: obscure,
        controller: controller,
        style: TextStyle(fontSize: fontSize),
        keyboardType: type,
        validator: validator,
        // autovalidateMode: autovalidateMode ??
        //     (validate == true
        //         ? AutovalidateMode.always
        //         : AutovalidateMode.onUserInteraction),
        decoration: InputDecoration(
          filled: true,
          fillColor: fieldColor,
          hintText: hint,
          contentPadding: const EdgeInsets.only(left: 12.0, right: 12),
          hintStyle: TextStyle(color: hintColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide.none,
          ),
        ),
        cursorColor: Colors.black,
        maxLines: maxlines == true ? null : 1,
      ),
    );
  }
}
