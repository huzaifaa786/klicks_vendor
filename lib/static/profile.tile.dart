// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, this.image, this.text, this.ontap});
  final image;
  final text;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(image),
                SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SvgPicture.asset('assets/images/arrow_right.svg',color: Colors.black,),
          ],
        ),
      ),
    );
  }
}
