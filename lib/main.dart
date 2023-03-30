// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:klicks_vendor/helpers/loading.dart';
import 'package:klicks_vendor/modals/language.dart';
import 'package:klicks_vendor/screen/edit_profile.dart/edit_profile.dart';
import 'package:klicks_vendor/screen/login/login.dart';
import 'package:klicks_vendor/screen/main/main.dart';
import 'package:klicks_vendor/screen/main/translation_screen.dart';
import 'package:klicks_vendor/screen/notification/notification.dart';
import 'package:klicks_vendor/screen/order_history/order_history.dart';
import 'package:klicks_vendor/screen/order_status/order_status.dart';
import 'package:klicks_vendor/screen/services/service.dart';
import 'package:klicks_vendor/screen/splash/splash_screen.dart';
import 'package:klicks_vendor/translations/codegen_loader.g.dart';
import 'package:klicks_vendor/values/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: Language.all,
      path: 'assets/translations',
      useFallbackTranslations: true,
      fallbackLocale: Language.all[0],
      assetLoader: CodegenLoader(),
      child: const MyApp()));
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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
          'Lang': (context) => TranslateScreen(),
          // 'otp': (context) => OtpScreen(),
        },
      ),
    );
  }
}
