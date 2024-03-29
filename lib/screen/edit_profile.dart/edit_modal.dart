import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/pass_inputfield_two.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;

import 'package:klicks_vendor/translations/locale_keys.g.dart';

class EditModel extends StatefulWidget {
  const EditModel({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<EditModel> createState() => _EditModelState();
}

class _EditModelState extends State<EditModel> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  bool _passwordVisible = true;
  bool _newpasswordVisible = true;
  bool _cpasswordVisible = true;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggle1() {
    setState(() {
      _newpasswordVisible = !_newpasswordVisible;
    });
  }

  void _toggle2() {
    setState(() {
      _cpasswordVisible = !_cpasswordVisible;
    });
  }

  change() async {
    if (currentPassword.text == '' ||
        newPassword.text == '' ||
        confirmNewPassword.text == '') {
      Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
    } else {
      if (newPassword.text != confirmNewPassword.text) {
        Fluttertoast.showToast(msg: 'New and Confirm password must be same');
      } else {
        if (await AuthApi.changeposward(
          widget.email.toString(),
          currentPassword,
          newPassword,
        )) {
          Navigator.pop(context);

          showDialog(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.of(context).pop(true);
                });
                return AlertDialog(
                  // title:
                  content: Container(
                    height: 150,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image(
                              image: AssetImage('assets/images/checked.png'),
                              height: 50,
                              width: 50),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.Password_changed.tr(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.successfully.tr(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
          currentPassword.text = '';
          newPassword.text = '';
          confirmNewPassword.text = '';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 6),
          Text(
            LocaleKeys.Current_Password.tr(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          SizedBox(height: 4),
          InputFieldPasswordTwo(
            hint: LocaleKeys.Enter_current_password.tr(),
            toggle: _toggle,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _passwordVisible,
            controller: currentPassword,
          ),
          SizedBox(height: 6),
          Text(
            LocaleKeys.New_Password.tr(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          SizedBox(height: 4),
          InputFieldPasswordTwo(
            hint: LocaleKeys.Enter_new_password.tr(),
            toggle: _toggle1,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _newpasswordVisible,
            controller: newPassword,
          ),
          SizedBox(height: 6),
          Text(
            LocaleKeys.Confirm_New_Password.tr(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          SizedBox(height: 4),
          InputFieldPasswordTwo(
            hint: LocaleKeys.Enter_confirm_new_password.tr(),
            toggle: _toggle2,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _cpasswordVisible,
            controller: confirmNewPassword,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LargeButton(
              title: LocaleKeys.Change.tr(),
              onPressed: () async {
                await change();
              },
            ),
          )
        ],
      ),
    );
  }
}
