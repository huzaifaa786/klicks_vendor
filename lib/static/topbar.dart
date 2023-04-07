// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klicks_vendor/api/notification.dart';
import 'package:klicks_vendor/screen/notification/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key});

  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  bool? checkNoti = false;

  checkNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    String? authCheck = prefs.getString('api_token');
    print(authCheck);
    if (authCheck != null) {
      var mcheckNotification = await NotificationApi.CheckNotications();
      setState(() {
        checkNoti = mcheckNotification;
        print(checkNoti);
      });
    } else {}
  }

  refreshData() {
    checkNotifications();
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      checkNotifications();
    });
  }

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
                  Route route = MaterialPageRoute(
                      builder: (context) => NotificationScreen());
                  Navigator.push(context, route).then(onGoBack);
                },
                child: SvgPicture.asset('assets/images/bell.svg'),
              ),
              checkNoti != false
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
