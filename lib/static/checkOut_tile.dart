// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:klicks_vendor/values/colors.dart';

class CheckOutTile extends StatelessWidget {
  const CheckOutTile(
      {super.key,
      this.title,
      this.discription,
      this.extra = false,
      this.services});
  final title;
  final discription;
  final bool extra;
  final Widget? services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 14, color: colorgrey),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              discription,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
