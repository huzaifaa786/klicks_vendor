import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/api.dart';
import 'package:klicks_vendor/helpers/loading.dart';
import 'package:klicks_vendor/modals/notification.dart';
import 'package:klicks_vendor/values/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification {
  static getcompany() async {
    LoadingHelper.show();
    var url = BASE_URL + 'companyget';
    var data;
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('company_id'));
    data = {'company_id': prefs.getString('company_id')!};

    var response = await Api.execute(url: url, data: data);
    LoadingHelper.dismiss();
    if (!response['error']) {
      Notifications notification = Notifications(response['notification']);
      return notification;
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }
}
