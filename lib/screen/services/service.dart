// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/api/extraservice.dart';
import 'package:klicks_vendor/modals/Service.dart';
import 'package:klicks_vendor/modals/company.dart';
import 'package:klicks_vendor/static/border_button.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/card.dart';
import 'package:klicks_vendor/static/extra_list_item.dart';
import 'package:klicks_vendor/static/imageinput.dart';
import 'package:klicks_vendor/static/inputfield.dart';
import 'package:klicks_vendor/static/price_field.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
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
                    company: company,
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
    var image1 = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = image1;
    });
  }

  List<ExtraService> services = [];
  getservice() async {
    var mservice = await ExtraServiceApi.getservice();
    setState(() {
      services = [];
      services = mservice;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getservice();
      await getcompany();
    });
  }

  Company? company;
  getcompany() async {
    var mcompany = await AuthApi.getcompany();
    setState(() {
      company = mcompany;
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
              company != null
                  ? Padding(
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
                                  text: company!.sedan_price,
                                  onpress: () {
                                    editprice(
                                      context,
                                      company!.suv_price,
                                      company!.sedan_price,
                                      company,
                                      company!.company_id,
                                    );
                                  },
                                ),
                                CardCar(
                                  image: 'assets/images/car2.png',
                                  text: company!.suv_price,
                                  onpress: () {
                                    editprice(
                                      context,
                                      company!.suv_price,
                                      company!.sedan_price,
                                      company,
                                      company!.company_id,
                                    );
                                  },
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
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
                                        color: Colors.black,
                                      ),
                                      Text(
                                        'ADD',
                                        // style: TextStyle(color: Colors.blue),
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
                                        hint: 'Service name',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          PriceInputField(
                                            controller: priceController,
                                            hint: '0.00',
                                            width: 0.42,
                                            type: TextInputType.number,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectimage();
                                            },
                                            child: ImageInput(
                                              text: image!.path == ''
                                                  ? 'Upload Image'
                                                  : image!.name,
                                            ),
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
                                            onPressed: () {
                                              setState(() {
                                                showCreate = !showCreate;
                                                print(showCreate);
                                              });
                                            },
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
                              SizedBox(height: 8),
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
                                        editServices(
                                            context,
                                            service.service_name,
                                            service.price,
                                            service.image,
                                            service.id,
                                            company);
                                      },
                                      removetap: () {
                                        DeleteService(
                                            context, service.id, company);
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
          // show == false
          //     ? Padding(
          //         padding: const EdgeInsets.only(bottom: 12),
          //         child: LargeButton(
          //             title: "Update",
          //             onPressed: () {
          //               setState(() {
          //                 show = !show;
          //                 print(show);
          //               });
          //             }),
          //       )
          //     : Padding(
          //         padding: const EdgeInsets.only(bottom: 12),
          //         child: IconsButton(
          //           title: 'Changes saved successfully!',
          //           color: Colors.green,
          //           rounded: true,
          //           onPressed: () {
          //             setState(() {
          //               show = !show;
          //             });
          //           },
          //         ),
          //       ),
        ],
      )),
    );
  }
}

editServices(context, service_name, price, imageUrl, id, company) {
  TextEditingController service_nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? image = XFile('');
  priceController.text = price;
  service_nameController.text = service_name;

  updata() async {
    if (service_nameController.text == '' || priceController.text == '') {
      Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
    } else {
      print('xvxc');
      if (image!.path == '') {
        await ExtraServiceApi.editservicewithoutImage(
            service_nameController, priceController, id);
      } else {
        final img = base64Encode(File(image!.path).readAsBytesSync());
        await ExtraServiceApi.editservice(
            service_nameController, priceController, img, id);
      }
    }
  }

  selectimage() async {
    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(source: ImageSource.gallery);
    // setState((){});
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
            keyboardType: TextInputType.number,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: image!.path == ''
                        ? Image(
                            image: NetworkImage(imageUrl),
                            width: 45,
                          )
                        : Image(
                            image: AssetImage(image!.path),
                            width: 45,
                          )),
                InkWell(
                    onTap: () {
                      selectimage();
                    },
                    child: ImageInput(
                      text: image!.path.isEmpty ? 'Upload Image' : image!.path,
                    )),
              ],
            ),
          )
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () async {
            await updata();
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Service(
                          company: company,
                        )));
          },
          child: Text(
            "save",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

DeleteService(context, id, company) async {
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
        onPressed: () async {
          await delservice();
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Service(
                        company: company,
                      )));
        },
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "NO",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context, false),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0),
        ]),
      )
    ],
  ).show();
}

editprice(context, suv_price, sedan_price, company, company_id) {
  TextEditingController suv_priceController = TextEditingController();
  TextEditingController sedan_priceController = TextEditingController();

  suv_priceController.text = suv_price;
  sedan_priceController.text = sedan_price;
  save() async {
    if (suv_priceController.text == '' || sedan_priceController.text == '') {
      Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
    } else {
      print('xvxc');

      await ExtraServiceApi.editprice(
          sedan_priceController, suv_priceController, company_id);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Service(
                    company: company,
                  )));
    }
  }

  Alert(
      context: context,
      title: "Edit Price",
      content: Column(
        children: <Widget>[
          TextField(
            controller: suv_priceController,
            decoration: InputDecoration(
              labelText: 'suv price',
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: sedan_priceController,
            decoration: InputDecoration(
              labelText: 'sedan price',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () async {
            await save();
          },
          child: Text(
            "save",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
