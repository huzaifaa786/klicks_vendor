class OrderModal {
  int? id;
  String? mall;
   String? company;
  String? parking;
  String? plate_number;
  String? floor;
   String? cartype;
   List? service = [''];

  OrderModal(order) {
    id = order['id'];
    mall = order['mall'] ['name'];
      company = order['company'] ['name'];
    parking = order['parking'];
    plate_number = order['number_plate'];
    floor = order['floor'];
      cartype = order['cartype'];
    service = order['service'] as List?;
  }
}
