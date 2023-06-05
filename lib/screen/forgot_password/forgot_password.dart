// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/modals/otp.dart';
import 'package:klicks_vendor/screen/otp/otp_screen.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/icon_inputfield.dart';
import 'package:klicks_vendor/translations/locale_keys.g.dart';
import "package:easy_localization/easy_localization.dart";
import "dart:ui" as ui;

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController emailController = TextEditingController();
  Otp? otp;
  getcompany() async {
    if (emailController.text == '') {
      Fluttertoast.showToast(msg: "Input can't be empty.");
    } else {
      var mcompany = await AuthApi.getcompanyUsingEmail(emailController.text);
      if (mcompany != false) {
        // log(company!.name.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              otp: mcompany.toString(),
              emailcontroller: emailController.text,
            ),
          ),
        );
      }
    }
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                              'assets/images/logo1.png',
                            ),
                            height: 220,
                            width: 220,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    LocaleKeys.Find_your_account.tr(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.Enter_email_address_linked_to_your_account.tr(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: IconInputField(
                      controller: emailController,
                      imageIcon: 'assets/images/email.svg',
                      hint: LocaleKeys.Eamil.tr(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 30),
                    child: LargeButton(
                      title: LocaleKeys.Next.tr(),
                      onPressed: () {
                        getcompany();
                        // AuthApi.getcompanyUsingEmail(emailController.text);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ChangePasswordScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
