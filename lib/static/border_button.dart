// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:klicks_vendor/values/colors.dart';

class BorderButton extends StatelessWidget {
  const BorderButton(
      {Key? key,
      @required this.title,
      @required this.onPressed,
      this.textcolor = hintColor,
      this.icon,
      this.borderClr,
      this.buttonWidth = 0.8,
      this.screenRatio = 0.9,
      this.rounded = false,
      this.color = White})
      : super(key: key);

  final title;
  final onPressed;
  final screenRatio;
  final color;
  final textcolor;
  final icon;
  final borderClr;
  final rounded;
  final buttonWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * screenRatio,
      // height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          // shadowColor: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(45)),
             side: BorderSide(width: 1, color: borderClr),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textcolor,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
