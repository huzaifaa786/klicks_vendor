import 'package:flutter/material.dart';
import 'package:klicks_vendor/static/button.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                          "Hello, Amal!",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      Text(
                        "Tuesday, January 3rd",
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
                              ontap: () {},
                              color: cardBlue,
                              title: 'Orders',
                              discription: 'Track your orders here',
                              image: 'assets/images/OrderBook.svg',
                            ),
                            MainCard(
                              ontap: () {},
                              color: cardgreen,
                              title: 'Services',
                              discription: 'List of our services',
                              image: 'assets/images/services.svg',
                            ),
                            MainCard(
                              ontap: () {},
                              color: cardorange,
                              title: 'Total Sale',
                              discription: 'Track your daily sale',
                              image: 'assets/images/sales.svg',
                            ),
                            MainCard(
                              ontap: () {},
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
                        ontap: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}