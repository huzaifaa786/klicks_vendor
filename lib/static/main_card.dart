// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klicks_vendor/values/colors.dart';

class MainCard extends StatelessWidget {
  const MainCard({super.key,this.color = cardBlue,this.title,this.discription,this.image,this.ontap});
  final color;
  final title;
  final discription;
  final image;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 42,
              left: 10,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(title,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(discription,
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: colorgrey))),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45), color: mainColor),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SvgPicture.asset(
                      image,
                      height: 18,
                      width: 18,
                      color: White,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
