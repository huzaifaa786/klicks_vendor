// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:klicks_vendor/api/notification.dart';
import 'package:klicks_vendor/modals/notification.dart';
import 'package:klicks_vendor/screen/notification/notification_detail.dart';
import 'package:klicks_vendor/static/notification_card.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/values/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModal> notification = [];

  getNotification() async {
    var mnotification = await NotificationApi.getnotifications();
    setState(() {
      notification = [];
      notification = mnotification;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: White,
      body: SafeArea(
          child: Column(
        children: [
          TitleTopbar(
            text: 'Notification',
            ontap: () {
              Navigator.pop(context);
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 14, right: 14,top: 12),
            height: MediaQuery.of(context).size.height * 0.89,
            child: ListView.builder(
                itemCount: notification.length,
                itemBuilder: (BuildContext context, int index) {
                  return NotificationTile(
                    type:  notification[index].cartype,
                    title: notification[index].title!,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationDetail(
                                  order: notification[index])));
                    },
                  );
                }),
          ),
        ],
      )),
    );
  }
}