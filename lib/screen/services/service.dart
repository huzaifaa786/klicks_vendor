// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:klicks_vendor/static/badge.dart';
import 'package:klicks_vendor/static/border_button.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/card.dart';
import 'package:klicks_vendor/static/edit_button.dart';
import 'package:klicks_vendor/static/icon_inputfield.dart';
import 'package:klicks_vendor/static/inputfield.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/static/topbar.dart';
import 'package:klicks_vendor/values/colors.dart';

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  bool showCreate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
        children: [
              TitleTopbar(
                text: 'Services',
                ontap: () {},
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.82,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CardCar(
                              image: 'assets/images/car2.png',
                            ),
                            CardCar(
                              image: 'assets/images/car2.png',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Extre Service',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                print(showCreate);
                                setState(() {
                                  showCreate = !showCreate;
                                  print(showCreate);
                                });
                              },
                              child: Row(
                                children: [
                                  Image.asset('assets/images/add.png'),
                                  Text(
                                    'Add new',
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      showCreate == true
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: InputField(
                                    hint: 'Enter Service name',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InputField(
                                        hint: 'AED',
                                        width: 0.42,
                                      ),
                                      IconInputField(
                                        imageIcon: 'assets/images/image.svg',
                                        hint: 'upload image',
                                        width: 0.42,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BorderButton(
                                        title: 'cancel',
                                        onPressed: () {},
                                        screenRatio: 0.42,
                                      ),
                                      LargeButton(
                                        title: 'Add',
                                        onPressed: () {},
                                        screenRatio: 0.42,
                                        rounded: true,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/tyre.png',
                                  height: 40,
                                  width: 40,
                                ),
                                Text(
                                  'Tyre Change',
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: EditButton(
                                    title: 'Edit',
                                    onPressed: () {},
                                    textcolor: Colors.green,
                                    screenRatio: 0.20,
                                    imgicon: 'assets/images/edit.svg',
                                    color: Colors.green.shade100,
                                  ),
                                ),
                                EditButton(
                                  title: 'Remove',
                                  onPressed: () {},
                                  screenRatio: 0.27,
                                  textcolor: Colors.red,
                                  imgicon: 'assets/images/delete.svg',
                                  color: Colors.red.shade100,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/oil.png',
                                  height: 40,
                                  width: 40,
                                ),
                                Text(
                                  'Oil Change',
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: EditButton(
                                    title: 'Edit',
                                    onPressed: () {},
                                    textcolor: Colors.green,
                                    screenRatio: 0.20,
                                    imgicon: 'assets/images/edit.svg',
                                    color: Colors.green.shade100,
                                  ),
                                ),
                                EditButton(
                                  title: 'Remove',
                                  onPressed: () {},
                                  screenRatio: 0.27,
                                  textcolor: Colors.red,
                                  imgicon: 'assets/images/delete.svg',
                                  color: Colors.red.shade100,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
        ],
      ),
      Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: LargeButton(title: 'Update', onPressed: () {}),
                  )
            ],
          )),
    );
  }
}
