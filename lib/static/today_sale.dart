import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodaySale extends StatelessWidget {
  const TodaySale({
    Key? key,
    this.text,
    this.icon,
    this.color,
    this.imageicon,
    this.shadowColor,
  }) : super(key: key);
  final text;
  final icon;
  final color;
  final imageicon;
  final shadowColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shadowColor: Colors.black,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Row(
                        children: [
                          Image.asset(
                            imageicon,
                            height: 40,
                            width: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Customer Name ',style: TextStyle(fontSize:15,fontWeight: FontWeight.w600 ),),
                                Text('SWEDAN'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                        Text('AED :23'),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
