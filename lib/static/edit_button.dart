// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klicks_vendor/values/colors.dart';

class EditButton extends StatelessWidget {
  const EditButton(
      {Key? key,
       this.title,
      @required this.onPressed,
      this.textcolor,
      this.icon,
      this.imgicon,
      this.iconTrue = true,
      this.screenRatio = 0.9,
      this.rounded = false,
      this.color = mainColor})
      : super(key: key);

  final title;
  final imgicon;
  final iconTrue;
  final onPressed;
  final screenRatio;
  final color;
  final textcolor;
  final icon;
  final rounded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * screenRatio,
      height: 30,
      child: InkWell(
        onTap: onPressed,
        // style: ElevatedButton.styleFrom(
        //   primary: color,
        //   shadowColor: mainColor,
         
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: SvgPicture.asset(imgicon,height: 15,width: 15,),
            ),
           
          ],
        ),
      ),
    );
  }
}
