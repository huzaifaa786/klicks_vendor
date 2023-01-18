import 'package:flutter/material.dart';
import 'package:klicks_vendor/screen/edit_profile.dart/edit_profile.dart';
import 'package:klicks_vendor/screen/login/login.dart';
import 'package:klicks_vendor/screen/main/main.dart';
import 'package:klicks_vendor/screen/notification/notification.dart';
import 'package:klicks_vendor/screen/order%20status/order_status.dart';
import 'package:klicks_vendor/screen/order_detail/order_detail.dart';
import 'package:klicks_vendor/screen/services/service.dart';
import 'package:klicks_vendor/screen/splash/splash_screen.dart';
import 'package:klicks_vendor/values/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Styles.lightTheme,
      title: "Klicks",
      initialRoute: 'order_detail',
      routes: {
        'splash': (context) => const SplashScreen(),
        'login': (context) => const LoginScreen(),
        'order_status': (context) => const OrderStatus(),
        'notification': (context) => const NotificationScreen(),
        'edit_profile': (context) => const EditProfile(),
        'main':(context) => MainScreen(),
          'service': (context) => const Service(),
          'order_detail': (context) => const OrderDetail(),
      },
    );
  }
}