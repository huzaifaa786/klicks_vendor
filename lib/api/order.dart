import 'package:klicks_vendor/api/api.dart';
import 'package:klicks_vendor/values/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order{
  static getservice() async {
    // LoadingHelper.show();
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
    // LoadingHelper.dismiss();
    List<ExtraService> extraservices = <ExtraService>[];
    for (var extraservice in response['services']) {
      extraservices.add(ExtraService(extraservice));
    }
    return extraservices;
  }









}