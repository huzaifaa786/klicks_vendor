// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:klicks_vendor/static/edit_button.dart';

class ExtraListTile extends StatelessWidget {
  const ExtraListTile(
      {super.key,
      this.image,
      this.text,
      this.edittap,
      this.removetap,
      this.selected = false});
  final image;
  final text;
  final edittap;
  final removetap;
  final selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        padding: EdgeInsets.all(12),
        height: 70,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image != null
                        ? Image(
                            image: CachedNetworkImageProvider(image.toString()),
                            fit: BoxFit.fill)
                        : Image(
                            image: AssetImage('assets/images/logo1.png'),
                            fit: BoxFit.contain),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: EditButton(
                    onPressed: edittap,
                    screenRatio: 0.05,
                    imgicon: 'assets/images/edit.svg',
                    color: Colors.white,
                  ),
                ),
                EditButton(
                  onPressed: removetap,
                  screenRatio: 0.15,
                  imgicon: 'assets/images/delete.svg',
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
