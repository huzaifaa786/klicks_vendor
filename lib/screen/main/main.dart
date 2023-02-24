// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/modals/company.dart';
import 'package:klicks_vendor/screen/edit_profile.dart/edit_profile.dart';
import 'package:klicks_vendor/screen/services/service.dart';
import 'package:klicks_vendor/screen/total_sales/total_sales.dart';
import 'package:klicks_vendor/static/language.dart';
import 'package:klicks_vendor/static/logoutTile.dart';
import 'package:klicks_vendor/static/main_card.dart';
import 'package:klicks_vendor/static/topbar.dart';
import 'package:klicks_vendor/values/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Company? company;
  DateTime? now;
  String? monthName;
  String? weekdayName;

  List<String> weekdays = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<String> monthNames = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  getcompany() async {
    var mcompany = await AuthApi.getcompany();
    setState(() {
      company = mcompany;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getcompany();
      now = DateTime.now();
      monthName = monthNames[now!.month];
      weekdayName = weekdays[now!.weekday];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: company != null
              ? Column(
                  children: [
                    Topbar(),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 4),
                                child: Text(
                                  "Hello, " + company!.username!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                              Text(
                                weekdayName! +
                                    ', ' +
                                    monthName! +
                                    ' ' +
                                    now!.day.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: GridView(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                  ),
                                  shrinkWrap: true,
                                  children: [
                                    MainCard(
                                      ontap: () {
                                        Navigator.pushNamed(context, 'history');
                                      },
                                      color: cardBlue,
                                      title: 'Orders',
                                      discription: 'Track your orders here',
                                      image: 'assets/images/OrderBook.svg',
                                    ),
                                    MainCard(
                                      ontap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Service(
                                                      company: company,
                                                    )));
                                      },
                                      color: cardgreen,
                                      title: 'Services',
                                      discription: 'List of our services',
                                      image: 'assets/images/services.svg',
                                    ),
                                    MainCard(
                                      ontap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SalesScreen(
                                                      id: company!.company_id
                                                          .toString(),
                                                    )));
                                      },
                                      color: cardorange,
                                      title: 'Total Sale',
                                      discription: 'Track your daily sale',
                                      image: 'assets/images/sales.svg',
                                    ),
                                    MainCard(
                                      ontap: () {
                                        // Navigator.pushNamed(
                                        //     context, 'edit_profile');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile(
                                                      company: company,
                                                    )));
                                      },
                                      color: cardpink,
                                      title: 'Profile',
                                      discription: 'Manage your Profile',
                                      image: 'assets/images/profile.svg',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              LanguageTile(
                                image: 'assets/images/language.svg',
                                text: 'Language',
                                ontap: () {},
                                language: 'English(US)',
                              ),
                              SizedBox(height: 8),
                              LogOutTile(
                                image: 'assets/images/logout.svg',
                                text: 'Log out',
                                ontap: () {
                                  AuthApi.logout();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, 'login', (route) => false);
                                  Fluttertoast.showToast(
                                      msg: "Logout successful");
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container()),
    );
  }
}
