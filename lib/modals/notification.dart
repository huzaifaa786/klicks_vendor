import 'package:klicks_vendor/modals/order.dart';

class NotificationModal {
  int? id;
  String? title;
  int? company_id;
  String? body;
  int? order_id;
  int? user_id;
  DateTime? dateTime;
  int? orderId;
  String? mall;
  String? company;
  String? parking;
  String? plate_number;
  String? floor;
  String? user;
  int? status;
  String? cartype;
  OrderModal? order;


  NotificationModal(noti) {
    id = noti['id'];
    title = noti['title'];
    order_id = noti['order_id'];
    body = noti['body'];
    company_id = noti['company_id'];
    user_id = noti['user_id'];
    dateTime = DateTime.parse(noti['created_at']);
    order = OrderModal(noti['order']);
    // mall = noti['order']['mall']['name'];


  }
}
