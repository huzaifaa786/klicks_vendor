import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconInput extends StatelessWidget {
  const IconInput({
    Key? key,
    this.textcolor,
    this.icon,
    this.text,
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
  final text;
  final icon;
  final rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 180,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text('AED'),
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          )
        ],
      ),
    );
  }
}
