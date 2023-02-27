// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:klicks_vendor/static/notification_card.dart';
import 'package:klicks_vendor/static/title_topbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TitleTopbar(
            text: 'Notification',
            ontap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GestureDetector(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: SvgPicture.asset('assets/images/backArrow.svg')),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Text(
                //     'Notification',
                //     style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.w600,
                //         fontFamily: 'Poppins'),
                //   ),
                // ),
                NotificationCard(
                  image: 'assets/images/Suv.png',
                  text: 'You have received a new order',
                  day: '.3d',
                ),
                NotificationCard(
                  image: 'assets/images/sedan.png',
                  text: 'You have received a new order',
                  day: '.3d',
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
