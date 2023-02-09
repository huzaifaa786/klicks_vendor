import 'package:dio/dio.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    var url = BASE_URL + 'companyLogin';
    var data = {'email': email.text, 'password': password.text};

    var response = await Api.execute(url: url, data: data);

    LoadingHelper.dismiss();
    if (!response['error']) {
      Company company = Company(response['company']);

      SharedPreferencesHelper.setString('api_token', company.apiToken!);
      print(response['company.api_token']);
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
    print(prefs.getString('api_token'));
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
}
