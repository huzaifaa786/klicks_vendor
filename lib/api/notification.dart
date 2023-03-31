import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/api.dart';
import 'package:klicks_vendor/helpers/loading.dart';
import 'package:klicks_vendor/modals/notification.dart';
import 'package:klicks_vendor/modals/order_detail.dart';
import 'package:klicks_vendor/values/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationApi {
   static getnotifications() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendernotfion';
    var data;
    final prefs = await SharedPreferences.getInstance();
    (prefs.getString('company_id'));
    data = {'company_id': prefs.getString('company_id')!};

    var response = await Api.execute(url: url, data: data);
    LoadingHelper.dismiss();
    if (!response['error']) {
      List<NotificationModal> notifications = <NotificationModal>[];
      for (var notification in response['notification']) {
        (response['notification']);
        notifications.add(NotificationModal(notification));
      }
      return notifications;
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }
    static MallandCmp(id) async {
    LoadingHelper.show();
    var url = BASE_URL + 'notificationdetail';
    var data = {'order_id': id};
    var response = await Api.execute(url: url, data: data);

    LoadingHelper.dismiss();
    if (!response['error']) {
      OrderDetail? noti = OrderDetail(response['orders']);
      (response['orders']['mall']['name']);
      return noti;
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }
}
