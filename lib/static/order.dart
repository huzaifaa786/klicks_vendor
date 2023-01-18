// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Order extends StatelessWidget {
  const Order({
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
                Text('Order ID :F5345'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          imageicon,
                          height: 40,
                          width: 40,
                        ),
                        Column(
                          children: [
                            Text('BMW'),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text('SWEDAN'),
                            ),
                          ],
                        ),
                      ],
                    ),
                        Text('jan 12 2023'),

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