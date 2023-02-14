import 'package:fluttertoast/fluttertoast.dart';
import 'package:klicks_vendor/api/api.dart';
import 'package:klicks_vendor/helpers/loading.dart';
import 'package:klicks_vendor/modals/Service.dart';
import 'package:klicks_vendor/values/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtraServiceApi {
  static addservice(service_name, price, image) async {
    LoadingHelper.show();
    var url = BASE_URL + 'addservice';
    var data;
    final prefs = await SharedPreferences.getInstance();

    data = {
      'company_id': int.parse(prefs.getString('company_id')!),
      'service_name': service_name.text.toString(),
      'price': price.text.toString(),
      'image': image,
    };
    print(data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    // print(response);
    LoadingHelper.dismiss();
    if (!response['error']) {
      // print(response['services']);
      ExtraService extraservice = ExtraService(response['services']);
      return true;
    } else {
      print('error');
      Fluttertoast.showToast(msg: response['error_data']);
      return false;
    }
  }

  static getservice() async {
    LoadingHelper.show();
    var url = BASE_URL + 'allservices';
    var data;
    final prefs = await SharedPreferences.getInstance();

    data = {'id': int.parse(prefs.getString('company_id')!)};
    print(data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    // print(response);
    LoadingHelper.dismiss();
    List<ExtraService> extraservices = <ExtraService>[];
    for (var extraservice in response['services']) {
      extraservices.add(ExtraService(extraservice));
    }
    return extraservices;
  }

  static delservice(id) async {
    LoadingHelper.show();
    var url = BASE_URL + 'delservice';
    var data;

    data = {'id': id};
    print(data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    // print(response);
    LoadingHelper.dismiss();
    return response;
  }

  static editservice(service_name, price, image, id) async {
    LoadingHelper.show();
    var url = BASE_URL + 'editservice';
    var data;

    data = {
      'service_name': service_name.text.toString(),
      'price': price.text.toString(),
      'image': image,
      'id': id,
    };
    print(data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    print(response);
    LoadingHelper.dismiss();
    return response;
  }

  static editservicewithoutImage(service_name, price, id) async {
    LoadingHelper.show();
    var url = BASE_URL + 'editservice';
    var data;

    data = {
      'service_name': service_name.text.toString(),
      'price': price.text.toString(),
      'id': id,
    };
    print(data);
    var response = await Api.execute(
      url: url,
      data: data,
    );
    print(response);
    LoadingHelper.dismiss();
    return response;
  }
}
