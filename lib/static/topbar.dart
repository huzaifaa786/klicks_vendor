// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key, this.checkNewNoti = false});
  final checkNewNoti;

  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: AssetImage(
              'assets/images/logo1.png',
            ),
            height: 63,
            width: 63,
          ),
          new Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'notification');
                },
                child: SvgPicture.asset('assets/images/bell.svg'),
              ),
              widget.checkNewNoti != false
                  ? new Positioned(
                      right: 1,
                      top: 1,
                      child: new Container(
                        padding: EdgeInsets.all(4),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    )
                  : new Container()
            ],
          ),
        ],
      ),
    );
  }
}
