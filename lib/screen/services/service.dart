// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:klicks_vendor/translations/locale_keys.g.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;

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
      ('xvxc');
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
    ('dsff');
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
      body: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TitleTopbar(
                  text: LocaleKeys.Services.tr(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.Extra_Services.tr(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      (showCreate);
                                      setState(() {
                                        showCreate = !showCreate;
                                        (showCreate);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/add.png',
                                          height: 15,
                                          width: 15,
                                          color: Colors.black,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Text(
                                            LocaleKeys.ADD.tr(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
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
                                          hint: LocaleKeys.Service_name.tr(),
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
                                              width: 0.43,
                                              type: TextInputType.number,
                                            ),
                                            SizedBox(width: 4),
                                            InkWell(
                                              onTap: () {
                                                selectimage();
                                              },
                                              child: ImageInput(
                                                text: image!.path == ''
                                                    ? LocaleKeys.upload_image
                                                        .tr()
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
                                              title: LocaleKeys.Cancel.tr(),
                                              onPressed: () {
                                                setState(() {
                                                  showCreate = !showCreate;
                                                  (showCreate);
                                                });
                                              },
                                              screenRatio: 0.42,
                                              borderClr: Colors.grey[300]!,
                                            ),
                                            BorderButton(
                                              title: LocaleKeys.Add.tr(),
                                              onPressed: () {
                                                save();
                                              },
                                              screenRatio: 0.42,
                                              color: mainColor,
                                              textcolor: White,
                                              borderClr: mainColor,
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
                                  ? MediaQuery.of(context).size.height * 0.30
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
            //                 (show);
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
      ),
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
      ('xvxc');
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
      title: LocaleKeys.edit_service.tr(),
      content: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Column(
          children: <Widget>[
            TextField(
              controller: service_nameController,
              decoration: InputDecoration(
                labelText: LocaleKeys.Service_name.tr(),
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: LocaleKeys.price.tr(),
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
                          ? Container(
                              height: 45,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: image != null
                                    ? Image(
                                        image: CachedNetworkImageProvider(
                                            imageUrl),
                                        fit: BoxFit.fill)
                                    : Image(
                                        image: AssetImage(
                                            'assets/images/logo1.png'),
                                        fit: BoxFit.contain),
                              ),
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
                        text: image!.path.isEmpty
                            ? LocaleKeys.upload_image.tr()
                            : image!.path,
                      )),
                ],
              ),
            )
          ],
        ),
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
            LocaleKeys.Save.tr(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

DeleteService(context, id, company) async {
  ('id');

  delservice() async {
    var mMalls = await ExtraServiceApi.delservice(id);
  }

  Alert(
    context: context,
    type: AlertType.warning,
    title: LocaleKeys.alert.tr(),
    desc: LocaleKeys.are_you_sure_to_want_delete.tr(),
    buttons: [
      DialogButton(
        child: Text(
          LocaleKeys.yes.tr(),
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
          LocaleKeys.No.tr(),
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
      ('xvxc');

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
      title: LocaleKeys.Edit_Price.tr(),
      content: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Column(
          children: <Widget>[
            TextField(
              controller: suv_priceController,
              decoration: InputDecoration(
                labelText: LocaleKeys.Suv_Price.tr(),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: sedan_priceController,
              decoration: InputDecoration(
                labelText: LocaleKeys.Sedan_Price.tr(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          onPressed: () async {
            await save();
          },
          child: Text(
            LocaleKeys.Save.tr(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
