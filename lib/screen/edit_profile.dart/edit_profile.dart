// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:klicks_vendor/modals/company.dart';
import 'package:klicks_vendor/screen/edit_profile.dart/edit_modal.dart';
import 'package:klicks_vendor/static/inputfield.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/translations/locale_keys.g.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, this.company});
  final Company? company;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool show = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // chnage() async {
  //   if (phoneController.text == '' ||
  //       emailController.text == '' ||
  //       passwordController.text == '') {
  //     Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
  //     setState(() {
  //       show = false;
  //     });
  //   } else {
  //     await AuthApi.changeposward(
  //       passwordController,
  //     );
  //     // Fluttertoast.showToast(msg: 'update successfully');
  //     setState(() {
  //       show = true;
  //     });
  //     passwordController.text = '';
  //   }
  // }

  void initState() {
    emailController.text = widget.company!.email!;
    phoneController.text = widget.company!.phone!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: SafeArea(
          child: Column(
            children: [
              TitleTopbar(
                ontap: () {
                  Navigator.pop(context);
                },
                text: LocaleKeys.Profile.tr(),
              ),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.89,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 6),
                            child: Text(
                              LocaleKeys.Eamil.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                          InputField(
                            readOnly: true,
                            hint: 'Enter Email',
                            controller: emailController,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 6),
                            child: Text(
                              LocaleKeys.Phone_Number.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                          InputField(
                            readOnly: true,
                            hint: 'Enter phone number',
                            controller: phoneController,
                            type: TextInputType.number,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.Password.tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                InkWell(
                                  onTap: () {
                                    ChangePassword(
                                        context, emailController.text);
                                  },
                                  child: Text(
                                    LocaleKeys.Change_Password.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: mainColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // InputFieldPasswordTwo(
                          //   hint: 'Password',
                          //   toggle: _toggle,
                          //   obscure: _obscureText,
                          //   controller: passwordController,
                          // ),
                        ],
                      ),
                      // show == false
                      //     ?
                      // Padding(
                      //         padding: const EdgeInsets.only(bottom: 12),
                      //         child: LargeButton(
                      //             title: "Update Profile",
                      //             onPressed: () {
                      //               chnage();
                      //             }),
                      //       )
                      //     : Padding(
                      //         padding: const EdgeInsets.only(bottom: 12),
                      //         child: IconsButton(
                      //           title: 'Changes saved successfully!',
                      //           color: Colors.green,
                      //           rounded: true,
                      //           onPressed: () {
                      //             // setState(() {
                      //             //   show = !show;
                      //             // });
                      //           },
                      //         ),
                      //       )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ChangePassword(context, email) {
    Alert(context: context, content: EditModel(email: email), buttons: [
      DialogButton(
          height: 0, color: White, onPressed: () async {}, child: Text(''))
    ]).show();
  }
}
