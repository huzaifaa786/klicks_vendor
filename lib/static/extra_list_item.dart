// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(image),
                height: 35,
                width: 35,
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
                  title: 'Edit',
                  onPressed: edittap,
                  textcolor: Colors.green,
                  screenRatio: 0.20,
                  imgicon: 'assets/images/edit.svg',
                  color: Colors.green.shade100,
                ),
              ),
              EditButton(
                title: 'Remove',
                onPressed: removetap,
                screenRatio: 0.27,
                textcolor: Colors.red,
                imgicon: 'assets/images/delete.svg',
                color: Colors.red.shade100,
              ),
            ],
          )
        ],
      ),
    );
  }
}
