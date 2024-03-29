import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/api.dart';
import 'package:klicks_vendor/helpers/loading.dart';
import 'package:klicks_vendor/modals/extra_service_detail.dart';
import 'package:klicks_vendor/modals/order.dart';
import 'package:klicks_vendor/modals/sale.dart';
import 'package:klicks_vendor/values/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderApi {
  static getorder() async {
    LoadingHelper.show();
    var url = BASE_URL + 'vendororder';
    var data;
    final prefs = await SharedPreferences.getInstance();

    data = {'id': int.parse(prefs.getString('company_id')!)};
    (data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    // (response);
    LoadingHelper.dismiss();
    List<OrderModal> orders = <OrderModal>[];
    for (var order in response['orders']) {
      orders.add(OrderModal(order));
    }
    return orders;
  }

  static ExtraServicesINOrder(id) async {
    LoadingHelper.show();
    var url = BASE_URL + 'orderdetail';
    var data;

    data = {'id': id};
    (data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    (response);
    LoadingHelper.dismiss();
    List<ExtraServiceDetail> extraservices = <ExtraServiceDetail>[];
    for (var extraservice in response['orders']) {
      extraservices.add(ExtraServiceDetail(extraservice));
    }
    return extraservices;
  }

  static orderaccept(id, userid, companyid) async {
    LoadingHelper.show();
    var url = BASE_URL + 'orderaccept';
    var data;
    (userid);
    (companyid);
    data = {'id': id, 'user_id': userid, "company_id": companyid};
    (data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    LoadingHelper.dismiss();
    if (!response['error']) {
      return true;
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }

  static orderreject(id, userid, companyid) async {
    LoadingHelper.show();
    var url = BASE_URL + 'orderreject';
    var data;

    data = {'id': id, 'user_id': userid, "company_id": companyid};
    (data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    LoadingHelper.dismiss();
    if (!response['error']) {
      return true;
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }

  static ordercomplete(id, userid, companyid) async {
    LoadingHelper.show();
    var url = BASE_URL + 'ordercomplete';
    var data;

    data = {'id': id, 'user_id': userid, "company_id": companyid};
    (data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    LoadingHelper.dismiss();
    if (!response['error']) {
      return true;
    } else {
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }

  static getcompleteorder() async {
    LoadingHelper.show();
    var url = BASE_URL + 'saleorder';
    var data;
    final prefs = await SharedPreferences.getInstance();

    data = {'id': int.parse(prefs.getString('company_id')!)};
    (data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    // (response);
    LoadingHelper.dismiss();
    List<SaleModal> orders = <SaleModal>[];
    for (var order in response['orders']) {
      orders.add(SaleModal(order));
    }
    return orders;
  }

  static getSlaes(String format, DateTime date, String id) async {
    LoadingHelper.show();
    var url = BASE_URL + 'totalsale';
    var data;
    data = {'format': format.toString(), 'date': date.toString(), 'id': id};
    (data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    LoadingHelper.dismiss();
    return response;
  }
}
