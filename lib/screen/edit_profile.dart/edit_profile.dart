// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/modals/company.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/icon_button.dart';
import 'package:klicks_vendor/static/inputfield.dart';
import 'package:klicks_vendor/static/pass_inputfield_two.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/values/colors.dart';

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

  chnage() async {
    if (phoneController.text == '' ||
        emailController.text == '' ||
        passwordController.text == '') {
      Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
      setState(() {
        show = false;
      });
    } else {
      await AuthApi.changeposward(
        passwordController,
      );
      // Fluttertoast.showToast(msg: 'update successfully');
      setState(() {
        show = true;
      });
      phoneController.text = '';
      emailController.text = '';
      passwordController.text = '';
    }
  }

  void initState() {
    emailController.text = widget.company!.email!;
    phoneController.text = widget.company!.phone!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TitleTopbar(
              ontap: () {
                Navigator.pop(context);
              },
              text: 'Edit Profile',
            ),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.89,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12.0, bottom: 6),
                          child: Text(
                            "Email",
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
                            "Phone Number",
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
                                "Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                "Chnage Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: mainColor),
                              ),
                            ],
                          ),
                        ),
                        InputFieldPasswordTwo(
                          hint: 'Password',
                          toggle: _toggle,
                          obscure: _obscureText,
                          controller: passwordController,
                        ),
                      ],
                    ),
                    show == false
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: LargeButton(
                                title: "Update Profile",
                                onPressed: () {
                                  chnage();
                                }),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: IconsButton(
                              title: 'Changes saved successfully!',
                              color: Colors.green,
                              rounded: true,
                              onPressed: () {
                                // setState(() {
                                //   show = !show;
                                // });
                              },
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
