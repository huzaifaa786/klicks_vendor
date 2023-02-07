import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({
    Key? key,
    this.textcolor,
    this.icon,
    this.imgicon,
    this.iconTrue = true,
    this.screenRatio = 0.9,
    this.rounded = false,
    this.color,
  });

  final imgicon;
  final iconTrue;
  final screenRatio;
  final color;
  final textcolor;
  final icon;
  final rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 180,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SvgPicture.asset('assets/images/image.svg'),
        Text(
          'Upload image',
          style: TextStyle(color: Colors.grey.shade600),
        )
      ]),
    );
  }
}
