// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klicks_vendor/values/colors.dart';

class MBadge extends StatelessWidget {
  const MBadge({
    Key? key,
    @required this.title,
    this.color = badgeGreen,
    this.rounded = false,
    this.ontap,
  }) : super(key: key);
  final title;
  final color;
  final rounded;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: fieldColor, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
