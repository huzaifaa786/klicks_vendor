import 'package:flutter/material.dart';
import 'package:klicks_vendor/values/colors.dart';

class CardCar extends StatelessWidget {
  const CardCar({
    Key? key,
    this.text,
    this.icon,
    this.color,
    this.imageicon,
    this.onpress,
    this.image,
    this.shadowColor,
  }) : super(key: key);
  final text;
  final icon;
  final color;
  final onpress;
  final imageicon;
  final shadowColor;
  final image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 4, right: 4, bottom: 16),
      // height: 140,
      width: MediaQuery.of(context).size.width * 0.44,
      child: Column(
        children: [
          Image(
            image: AssetImage(
              image,
            ),
          ),
          GestureDetector(
            onTap: onpress,
            child: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: grey),
                    ),
                  ),
                  child: Text(
                    'AED ' + text,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
