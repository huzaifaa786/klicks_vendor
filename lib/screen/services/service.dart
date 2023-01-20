// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:klicks_vendor/static/badge.dart';
import 'package:klicks_vendor/static/border_button.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/card.dart';
import 'package:klicks_vendor/static/edit_button.dart';
import 'package:klicks_vendor/static/extra_list_item.dart';
import 'package:klicks_vendor/static/icon_button.dart';
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
  bool show = false;

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
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
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

                    SizedBox(
                      height: showCreate == true
                          ? MediaQuery.of(context).size.height * 0.16
                          : MediaQuery.of(context).size.height * 0.45,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ExtraListTile(
                              image: 'assets/images/tyre.png',
                              text: 'Tyre Service',
                              edittap: (){},
                              removetap: (){},
                            ),
                            ExtraListTile(
                              image: 'assets/images/oil.png',
                              text: 'Oil Chnage',
                              edittap: (){},
                              removetap: (){},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          show == false
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: LargeButton(
                      title: "Update",
                      onPressed: () {
                        setState(() {
                          show = !show;
                          print(show);
                        });
                      }),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: IconsButton(
                    title: 'Changes saved successfully!',
                    color: Colors.green,
                    rounded: true,
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                  ),
                )
        ],
      )),
    );
  }
}
