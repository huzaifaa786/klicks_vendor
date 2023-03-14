// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/screen/forgot_password/forgot_password.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/icon_inputfield.dart';
import 'package:klicks_vendor/static/password_inputfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool checkboxval = false;
  bool _passwordVisible = true;

  bool emailValid = false;

  _togglecheckbox() {
    print(checkboxval);
    setState(() {
      checkboxval = !checkboxval;
    });
  }

  login() async {
    if (emailController.text == '' || passwordController.text == '') {
      // Fluttertoast.showToast(msg: 'Fill out all the Fields. Invalid!');
    } else {
      if (await AuthApi.login(
        emailController,
        passwordController,
      )) Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => MainScreen()));
    }
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    // Positioned(
                    //   bottom: 10,
                    //   left: 55,
                    //   child: Text(
                    //     "Sign in to continue",
                    //     style: TextStyle(
                    //       fontSize: 26,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                Text(
                  "Sign in to continue",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: IconInputField(
                    controller: emailController,
                    imageIcon: 'assets/images/email.svg',
                    hint: 'Email',
                    
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: InputFieldPassword(
                    controller: passwordController,
                    imageIcon: 'assets/images/lock.svg',
                    hint: 'Password',
                    toggle: _toggle,
                    obscure: _obscureText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotScreen()));
                        },
                        child: Text(
                          'Forgot Passowrd?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 30),
                  child: LargeButton(
                    title: "Sign in",
                    onPressed: () {
                      login();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
