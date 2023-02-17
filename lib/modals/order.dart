class OrderModal {
  int? id;
  String? mall;
   String? company;
  String? parking;
  String? plate_number;
  String? floor;
   String? user;
   String? cartype;
      String? price;
   List? service = [''];

  OrderModal(order) {
    id = order['id'];
    mall = order['mall'] ['name'];
      company = order['company']['name'];
    parking = order['parking'];
    plate_number = order['number_plate'];
    floor = order['floor'];
      price = order['totalpayment'] ?? '';
     user = order['user']['name'] ?? '';
      cartype = order['cartype'];
    service = order['service'] as List?;
  }
}
