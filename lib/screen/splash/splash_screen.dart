// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:klicks_vendor/helpers/loading.dart';
import 'package:klicks_vendor/screen/login/login.dart';
import 'package:klicks_vendor/screen/main/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final String? authCheck = prefs.getString('api_token');
    if (authCheck == null) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new MainScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    LoadingHelper.init();
    initscreen();
  }

  void initscreen() async {
    await Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      checkFirstSeen();
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   initscreen();
  // }

  // void initscreen() async {
  //   await Future.delayed(
  //       const Duration(
  //         seconds: 3,
  //       ), () {
  //     Navigator.popAndPushNamed(context, 'login');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: const Center(
          child: Image(
            image: AssetImage(
              'assets/images/logo1.png',
            ),
            height: 350,
            width: 350,
          ),
        ),
      ),
    );
  }
}
