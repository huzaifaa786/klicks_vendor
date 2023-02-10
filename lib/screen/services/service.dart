// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/api/extraservice.dart';
import 'package:klicks_vendor/modals/Service.dart';
import 'package:klicks_vendor/modals/company.dart';
import 'package:klicks_vendor/static/badge.dart';
import 'package:klicks_vendor/static/border_button.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/card.dart';
import 'package:klicks_vendor/static/edit_button.dart';
import 'package:klicks_vendor/static/extra_list_item.dart';
import 'package:klicks_vendor/static/icon_button.dart';
import 'package:klicks_vendor/static/icon_inputfield.dart';
import 'package:klicks_vendor/static/imageinput.dart';
import 'package:klicks_vendor/static/inputfield.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/static/topbar.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Service extends StatefulWidget {
  const Service({super.key, this.company});
  final Company? company;
  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  TextEditingController service_nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? image = XFile('');

  save() async {
    if (service_nameController.text == '' ||
        priceController.text == '' ||
        image!.path == '') {
      Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
    } else {
      print('xvxc');
      final img = base64Encode(File(image!.path).readAsBytesSync());
      await ExtraServiceApi.addservice(
          service_nameController, priceController, img);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Service(
                    company: widget.company,
                  )));
      service_nameController.text = '';
      priceController.text = '';
      image = XFile('');
    }
  }

  bool showCreate = false;
  bool show = false;
  selectimage() async {
    print('dsff');
    final ImagePicker _picker = ImagePicker();

    image = await _picker.pickImage(source: ImageSource.gallery);
  }

  List<ExtraService> services = [];
  getservice() async {
    var mservice = await ExtraServiceApi.getservice();
    setState(() {
      services = mservice;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getservice();
    });
  }

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
                            image: 'assets/images/car1.png',
                            text: widget.company!.suv_price,
                          ),
                          CardCar(
                            image: 'assets/images/car2.png',
                            text: widget.company!.sedan_price,
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
                                Image.asset(
                                  'assets/images/add.png',
                                  height: 14,
                                  width: 14,
                                ),
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
                                  controller: service_nameController,
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
                                      controller: priceController,
                                      hint: 'AED',
                                      width: 0.42,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        selectimage();
                                      },
                                      child: ImageInput(),
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
                                      onPressed: () {
                                        save();
                                      },
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
                            for (var service in services)
                              ExtraListTile(
                                image: service.image,
                                text: service.service_name,
                                edittap: () {
                                  _onAlertWithCustomContentPressed(
                                      context,
                                      service.service_name,
                                      service.price,
                                      service.image,
                                      
                                      service.id);
                                },
                                removetap: () {
                                  _onAlertButtonsPressed(context, service.id,);
                                },
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
                ),
        ],
      )),
    );
  }
}

_onAlertWithCustomContentPressed(context, service_name, price, imageUrl, id) {
  TextEditingController service_nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? image = XFile('');
  priceController.text = price;
  service_nameController.text = service_name;

  updata() async {
    if (service_nameController.text == '' ||
        priceController.text == '') {
      Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
    } else {
      print('xvxc');
      final img = base64Encode(File(image!.path).readAsBytesSync());
      await ExtraServiceApi.editservice(
          service_nameController, priceController, img, id);
    }
  }

  selectimage() async {
    print('dsff');
    final ImagePicker _picker = ImagePicker();

    image = await _picker.pickImage(source: ImageSource.gallery);
  }

  Alert(
      context: context,
      title: "Edit Service",
      content: Column(
        children: <Widget>[
          TextField(
            controller: service_nameController,
            decoration: InputDecoration(
              labelText: 'service name',
            ),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'price',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Image(
                    image: NetworkImage(imageUrl),
                    height: 45,
                    width: 45,
                  ),
                ),
                InkWell(
                    onTap: () {
                      selectimage();
                    },
                    child: ImageInput()),
              ],
            ),
          )
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            updata();
          },
          child: Text(
            "save",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

_onAlertButtonsPressed(context, id) {
  print('id');

  delservice() async {
    var mMalls = await ExtraServiceApi.delservice(id);
  }

  Alert(
    context: context,
    type: AlertType.warning,
    title: " ALERT",
    desc: "Are you sure to want delete ?",
    buttons: [
      DialogButton(
        child: Text(
          "YES",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          delservice();
            Navigator.pop(context);
     
        },
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "NO",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0),
        ]),
      )
    ],
  ).show();
}
