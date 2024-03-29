import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({
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
      width: MediaQuery.of(context).size.width*0.43,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: SvgPicture.asset('assets/images/image.svg'),
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
