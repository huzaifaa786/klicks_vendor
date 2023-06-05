import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:klicks_vendor/api/api.dart';
import 'package:klicks_vendor/helpers/loading.dart';
import 'package:klicks_vendor/helpers/shared_pref.dart';
import 'package:klicks_vendor/modals/company.dart';
import 'package:klicks_vendor/values/string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static login(email, password) async {
    LoadingHelper.show();
    var token = await FirebaseMessaging.instance.getToken();
    var url = BASE_URL + 'companyLogin';
    var data = {
      'email': email.text,
      'password': password.text,
      'firebase_token': token,
    };

    var response = await Api.execute(url: url, data: data);

    LoadingHelper.dismiss();
    if (!response['error']) {
      Company company = Company(response['company']);

      SharedPreferencesHelper.setString('api_token', company.apiToken!);
      SharedPreferencesHelper.setString(
          'company_id', company.company_id.toString());
      (response['company.api_token']);
      SharedPreferencesHelper.setString(
          'company_id', company.company_id.toString());
      return true;
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }

  static getcompany() async {
    LoadingHelper.show();
    var url = BASE_URL + 'companyget';
    var data;
    final prefs = await SharedPreferences.getInstance();
    (prefs.getString('api_token'));
    data = {'api_token': prefs.getString('api_token')!};

    var response = await Api.execute(url: url, data: data);
    LoadingHelper.dismiss();
    if (!response['error']) {
      Company company = Company(response['company']);
      return company;
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }

  static Future logout() async {
    SharedPreferencesHelper.remove('api_token');
  }

  static changeposward(String email, password, newPassword) async {
    LoadingHelper.show();
    var url = BASE_URL + 'changepasword';
    var data;
    data = {
      'email': email,
      'password': password.text,
      'newpassword': newPassword.text
    };

    var response = await Api.execute(url: url, data: data);

    LoadingHelper.dismiss();
    if (response['error'] == false) {
      return true;
    } else {
      Fluttertoast.showToast(msg: response['error']);
      return false;
    }
    // return response;
  }

  static ResetPassword(password, api_token) async {
    LoadingHelper.show();
    var url = BASE_URL + 'changepasword';
    var data;
    final prefs = await SharedPreferences.getInstance();
    (prefs.getString('api_token'));
    data = {'api_token': api_token, 'password': password.text};

    var response = await Api.execute(url: url, data: data);

    LoadingHelper.dismiss();
    return response;
  }

  static getcompanyUsingEmail(email) async {
    LoadingHelper.show();
    var url = BASE_URL + 'forgetpasword';
    var data = {'email': email};

    var response = await Api.execute(url: url, data: data);
    LoadingHelper.dismiss();
    if (!response['error']) {
      return response['otp'];
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }

  static forget(email, password) async {
    log(email);
    log(password);
    LoadingHelper.show();
    var url = BASE_URL + 'forget';
    var data = {'email': email, 'password': password};
    var response = await Api.execute(url: url, data: data);

    LoadingHelper.dismiss();
    return response;
  }
}
