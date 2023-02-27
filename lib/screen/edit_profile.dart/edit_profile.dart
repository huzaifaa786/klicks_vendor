// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/modals/company.dart';
import 'package:klicks_vendor/static/inputfield.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            TitleTopbar(
              ontap: () {
                Navigator.pop(context);
              },
              text: 'Profile',
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
                              InkWell(
                                onTap: () {
                                  ChangePassword(context, emailController.text);
                                },
                                child: Text(
                                  "Chnage Password",
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
    );
  }

  ChangePassword(context, email) {
    TextEditingController currentPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmNewPassword = TextEditingController();

    change() async {
      if (currentPassword.text == '' ||
          newPassword.text == '' ||
          confirmNewPassword.text == '') {
        Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
      } else {
        if (newPassword.text != confirmNewPassword.text) {
          Fluttertoast.showToast(msg: 'New and Confirm password must be same');
        } else {
          await AuthApi.changeposward(
            email.toString(),
            currentPassword,
            newPassword,
          );
          Navigator.pop(context);
          currentPassword.text = '';
          newPassword.text = '';
          confirmNewPassword.text = '';
        }
      }
    }

    Alert(
        context: context,
        title: "Change Password",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 6),
            Text(
              "Current Password",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(height: 4),
            InputField(
              hint: 'Enter current password',
              obscure: true,
              controller: currentPassword,
            ),
            SizedBox(height: 6),
            Text(
              "New Password",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(height: 4),
            InputField(
              hint: 'Enter new password',
              obscure: true,
              controller: newPassword,
            ),
            SizedBox(height: 6),
            Text(
              "Confirm New Password",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(height: 4),
            InputField(
              hint: 'Enter confirm new password',
              obscure: true,
              controller: confirmNewPassword,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: mainColor,
            onPressed: () async {
              await change();
            },
            child: Text(
              "Change Password",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ]).show();
  }
}
