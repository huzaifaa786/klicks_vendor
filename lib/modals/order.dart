class Order {
  int? id;
  String? mall;
  String? parking;
  String? plate_number;
  String? floor;

  Order(order) {
    id = order['id'];
    mall = order['mall'];
    parking = order['parking'];
    plate_number = order['plate_number'];
    floor = order['floor'];
  }
}
