// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:klicks_vendor/helpers/loading.dart';
import 'package:klicks_vendor/screen/edit_profile.dart/edit_profile.dart';
import 'package:klicks_vendor/screen/login/login.dart';
import 'package:klicks_vendor/screen/main/main.dart';
import 'package:klicks_vendor/screen/notification/notification.dart';
import 'package:klicks_vendor/screen/order%20status/order_status.dart';
import 'package:klicks_vendor/screen/order_history/order_history.dart';
import 'package:klicks_vendor/screen/otp/otp_screen.dart';
import 'package:klicks_vendor/screen/total_sales/total_sales.dart';
import 'package:klicks_vendor/screen/services/service.dart';
import 'package:klicks_vendor/screen/splash/splash_screen.dart';
import 'package:klicks_vendor/values/styles.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  update() {
    setState(() {});
  }

  @override
  void initState() {
    LoadingHelper.onChangeAbsorbClick = update;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: LoadingHelper.absorbClick,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(),
        theme: Styles.lightTheme,
        title: "Klicks",
        initialRoute: 'splash',
        routes: {
          'splash': (context) => const SplashScreen(),
          'login': (context) => const LoginScreen(),
          'order_status': (context) => const OrderStatus(),
          'notification': (context) => const NotificationScreen(),
          'edit_profile': (context) => const EditProfile(),
          'main': (context) => MainScreen(),
          'service': (context) => const Service(),
          // 'sales': (context) => const SalesScreen(),
          'history': (context) => const OrderHistry(),
          // 'otp': (context) => OtpScreen(),
        },
      ),
    );
  }
}
